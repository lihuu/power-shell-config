# Name of Hyper-V VM
$vm = "Win11"

# Total VRAM of physical GPU (GPU-P)
$TotalGPUpVram = 6Gb

# Percent of physical GPU resources to allocate to virtual GPU in the VM
[int]$GPUpAllocationPercent = 25

# Calculate the high memory mapped IO value based on total GPU-P VRAM
# If driver issue (Code 43), this is the first thing to tweak by increasing $HighMMIO
$HighMMIO = $TotalGPUpVram * 2

###################### (should not need to modify below) ##################

# Get the partionable GPU in the physical system
# If you have multiple GPUs, run the get cmdlet, select its Name attribute, and add it as a paramter.
$partGPU = Get-VMHostPartitionableGpu

# Remove any existing GPU added to the VM (incase you are changing parameters)
# Remove-VMGpuPartitionAdapter -VMName $vm

# Add GPU to the VM
Add-VMGpuPartitionAdapter -VMName $vm

# Collect the parameters to apply to the GPU allocated to the VM (splatting)
$gpuParams = @{
    VMName                  = $vm
    MinPartitionVRAM        = ([math]::round($($partGPU.MinPartitionVRAM * $GPUpAllocationPercent / 100)))
    MaxPartitionVRAM        = ([math]::round($($partGPU.MaxPartitionVRAM * $GPUpAllocationPercent / 100)))
    OptimalPartitionVRAM    = ([math]::round($($partGPU.OptimalPartitionVRAM * $GPUpAllocationPercent / 100)))
    MinPartitionEncode      = ([math]::round($($partGPU.MinPartitionEncode * $GPUpAllocationPercent / 100)))
    MaxPartitionEncode      = ([math]::round($($partGPU.MaxPartitionEncode * $GPUpAllocationPercent / 100)))
    OptimalPartitionEncode  = ([math]::round($($partGPU.OptimalPartitionEncode * $GPUpAllocationPercent / 100)))
    MinPartitionDecode      = ([math]::round($($partGPU.MinPartitionDecode * $GPUpAllocationPercent / 100)))
    MaxPartitionDecode      = ([math]::round($($partGPU.MaxPartitionDecode * $GPUpAllocationPercent / 100)))
    OptimalPartitionDecode  = ([math]::round($($partGPU.OptimalPartitionDecode * $GPUpAllocationPercent / 100)))
    MinPartitionCompute     = ([math]::round($($partGPU.MinPartitionCompute * $GPUpAllocationPercent / 100)))
    MaxPartitionCompute     = ([math]::round($($partGPU.MaxPartitionCompute * $GPUpAllocationPercent / 100)))
    OptimalPartitionCompute = ([math]::round($($partGPU.OptimalPartitionCompute * $GPUpAllocationPercent / 100)))
}
Set-VMGpuPartitionAdapter @gpuParams

# View the results of adding the GPU to the VM
Get-VMGpuPartitionAdapter -VMName $vm

# Set required attributes on the VM
$vmParams = @{
    VMName                    = $vm
    GuestControlledCacheTypes = $true
    LowMemoryMappedIoSpace    = 1Gb
    HighMemoryMappedIoSpace   = $HighMMIO
}
Set-VM @vmParams

# copy the GPU driver to the VM
# Copy-VMFile -Name $vm -SourcePath "C:\Windows\System32\DriverStore\FileRepository\nv_dispi.inf_amd64_1c1f1b0b1b0f1b0b\nvlddmkm.sys" -DestinationPath "C:\Windows\System32\drivers\nvlddmkm.sys"
# Hostsrc C:\Windows\System32\DriverStore\FileRepository\ to VMDesc C:\Windows\System32\HostDriverStore\FileRepository\ just nvdia related files
# copy C:\Windows\System32\nvapi64.dll to C:\Windows\System32\nvapi64.dll
# https://www.freedidi.com/9857.html
# Option (not typically needed) to set VM display resolution
# Set-VMVideo -VMName $vm -HorizontalResolution 1920 -VerticalResolution 1200 -ResolutionType Maximum
