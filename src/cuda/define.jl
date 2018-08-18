const define = Dict{Symbol,Symbol}()

if API_VERSION[] >= 3020
    define[:cuDeviceTotalMem]           = :cuDeviceTotalMem_v2
    define[:cuCtxCreate]                = :cuCtxCreate_v2
    define[:cuModuleGetGlobal]          = :cuModuleGetGlobal_v2
    define[:cuMemGetInfo]               = :cuMemGetInfo_v2
    define[:cuMemAlloc]                 = :cuMemAlloc_v2
    define[:cuMemAllocPitch]            = :cuMemAllocPitch_v2
    define[:cuMemFree]                  = :cuMemFree_v2
    define[:cuMemGetAddressRange]       = :cuMemGetAddressRange_v2
    define[:cuMemAllocHost]             = :cuMemAllocHost_v2
    define[:cuMemHostGetDevicePointer]  = :cuMemHostGetDevicePointer_v2
    define[:cuMemcpyHtoD]               = :cuMemcpyHtoD_v2
    define[:cuMemcpyDtoH]               = :cuMemcpyDtoH_v2
    define[:cuMemcpyDtoD]               = :cuMemcpyDtoD_v2
    define[:cuMemcpyDtoA]               = :cuMemcpyDtoA_v2
    define[:cuMemcpyAtoD]               = :cuMemcpyAtoD_v2
    define[:cuMemcpyHtoA]               = :cuMemcpyHtoA_v2
    define[:cuMemcpyAtoH]               = :cuMemcpyAtoH_v2
    define[:cuMemcpyAtoA]               = :cuMemcpyAtoA_v2
    define[:cuMemcpyHtoAAsync]          = :cuMemcpyHtoAAsync_v2
    define[:cuMemcpyAtoHAsync]          = :cuMemcpyAtoHAsync_v2
    define[:cuMemcpy2D]                 = :cuMemcpy2D_v2
    define[:cuMemcpy2DUnaligned]        = :cuMemcpy2DUnaligned_v2
    define[:cuMemcpy3D]                 = :cuMemcpy3D_v2
    define[:cuMemcpyHtoDAsync]          = :cuMemcpyHtoDAsync_v2
    define[:cuMemcpyDtoHAsync]          = :cuMemcpyDtoHAsync_v2
    define[:cuMemcpyDtoDAsync]          = :cuMemcpyDtoDAsync_v2
    define[:cuMemcpy2DAsync]            = :cuMemcpy2DAsync_v2
    define[:cuMemcpy3DAsync]            = :cuMemcpy3DAsync_v2
    define[:cuMemsetD8]                 = :cuMemsetD8_v2
    define[:cuMemsetD16]                = :cuMemsetD16_v2
    define[:cuMemsetD32]                = :cuMemsetD32_v2
    define[:cuMemsetD2D8]               = :cuMemsetD2D8_v2
    define[:cuMemsetD2D16]              = :cuMemsetD2D16_v2
    define[:cuMemsetD2D32]              = :cuMemsetD2D32_v2
    define[:cuArrayCreate]              = :cuArrayCreate_v2
    define[:cuArrayGetDescriptor]       = :cuArrayGetDescriptor_v2
    define[:cuArray3DCreate]            = :cuArray3DCreate_v2
    define[:cuArray3DGetDescriptor]     = :cuArray3DGetDescriptor_v2
    define[:cuTexRefSetAddress]         = :cuTexRefSetAddress_v2
    define[:cuTexRefGetAddress]         = :cuTexRefGetAddress_v2
    define[:cuGraphicsResourceGetMappedPointer] = :cuGraphicsResourceGetMappedPointer_v2
end
if API_VERSION[] >= 4000
    define[:cuCtxDestroy]               = :cuCtxDestroy_v2
    define[:cuCtxPopCurrent]            = :cuCtxPopCurrent_v2
    define[:cuCtxPushCurrent]           = :cuCtxPushCurrent_v2
    define[:cuStreamDestroy]            = :cuStreamDestroy_v2
    define[:cuEventDestroy]             = :cuEventDestroy_v2
end
if API_VERSION[] >= 4010
    define[:cuTexRefSetAddress2D]       = :cuTexRefSetAddress2D_v3
end
if API_VERSION[] >= 6050
    define[:cuLinkCreate]              = :cuLinkCreate_v2
    define[:cuLinkAddData]             = :cuLinkAddData_v2
    define[:cuLinkAddFile]             = :cuLinkAddFile_v2
end
if API_VERSION[] >= 6050
    define[:cuMemHostRegister]         = :cuMemHostRegister_v2
    define[:cuGraphicsResourceSetMapFlags] = :cuGraphicsResourceSetMapFlags_v2
end
if 3020 <= API_VERSION[] < 4010
    define[:cuTexRefSetAddress2D]      = :cuTexRefSetAddress2D_v2
end

const CUDA_SUCCESS                              = Cint(0)
const CUDA_ERROR_INVALID_VALUE                  = Cint(1)
const CUDA_ERROR_OUT_OF_MEMORY                  = Cint(2)
const CUDA_ERROR_NOT_INITIALIZED                = Cint(3)
const CUDA_ERROR_DEINITIALIZED                  = Cint(4)
const CUDA_ERROR_PROFILER_DISABLED              = Cint(5)
const CUDA_ERROR_PROFILER_NOT_INITIALIZED       = Cint(6)
const CUDA_ERROR_PROFILER_ALREADY_STARTED       = Cint(7)
const CUDA_ERROR_PROFILER_ALREADY_STOPPED       = Cint(8)
const CUDA_ERROR_NO_DEVICE                      = Cint(100)
const CUDA_ERROR_INVALID_DEVICE                 = Cint(101)
const CUDA_ERROR_INVALID_IMAGE                  = Cint(200)
const CUDA_ERROR_INVALID_CONTEXT                = Cint(201)
const CUDA_ERROR_CONTEXT_ALREADY_CURRENT        = Cint(202)
const CUDA_ERROR_MAP_FAILED                     = Cint(205)
const CUDA_ERROR_UNMAP_FAILED                   = Cint(206)
const CUDA_ERROR_ARRAY_IS_MAPPED                = Cint(207)
const CUDA_ERROR_ALREADY_MAPPED                 = Cint(208)
const CUDA_ERROR_NO_BINARY_FOR_GPU              = Cint(209)
const CUDA_ERROR_ALREADY_ACQUIRED               = Cint(210)
const CUDA_ERROR_NOT_MAPPED                     = Cint(211)
const CUDA_ERROR_NOT_MAPPED_AS_ARRAY            = Cint(212)
const CUDA_ERROR_NOT_MAPPED_AS_POINTER          = Cint(213)
const CUDA_ERROR_ECC_UNCORRECTABLE              = Cint(214)
const CUDA_ERROR_UNSUPPORTED_LIMIT              = Cint(215)
const CUDA_ERROR_CONTEXT_ALREADY_IN_USE         = Cint(216)
const CUDA_ERROR_PEER_ACCESS_UNSUPPORTED        = Cint(217)
const CUDA_ERROR_INVALID_PTX                    = Cint(218)
const CUDA_ERROR_INVALID_GRAPHICS_CONTEXT       = Cint(219)
const CUDA_ERROR_NVLINK_UNCORRECTABLE           = Cint(220)
const CUDA_ERROR_JIT_COMPILER_NOT_FOUND         = Cint(221)
const CUDA_ERROR_INVALID_SOURCE                 = Cint(300)
const CUDA_ERROR_FILE_NOT_FOUND                 = Cint(301)
const CUDA_ERROR_SHARED_OBJECT_SYMBOL_NOT_FOUND = Cint(302)
const CUDA_ERROR_SHARED_OBJECT_INIT_FAILED      = Cint(303)
const CUDA_ERROR_OPERATING_SYSTEM               = Cint(304)
const CUDA_ERROR_INVALID_HANDLE                 = Cint(400)
const CUDA_ERROR_NOT_FOUND                      = Cint(500)
const CUDA_ERROR_NOT_READY                      = Cint(600)
const CUDA_ERROR_ILLEGAL_ADDRESS                = Cint(700)
const CUDA_ERROR_LAUNCH_OUT_OF_RESOURCES        = Cint(701)
const CUDA_ERROR_LAUNCH_TIMEOUT                 = Cint(702)
const CUDA_ERROR_LAUNCH_INCOMPATIBLE_TEXTURING  = Cint(703)
const CUDA_ERROR_PEER_ACCESS_ALREADY_ENABLED    = Cint(704)
const CUDA_ERROR_PEER_ACCESS_NOT_ENABLED        = Cint(705)
const CUDA_ERROR_PRIMARY_CONTEXT_ACTIVE         = Cint(708)
const CUDA_ERROR_CONTEXT_IS_DESTROYED           = Cint(709)
const CUDA_ERROR_ASSERT                         = Cint(710)
const CUDA_ERROR_TOO_MANY_PEERS                 = Cint(711)
const CUDA_ERROR_HOST_MEMORY_ALREADY_REGISTERED = Cint(712)
const CUDA_ERROR_HOST_MEMORY_NOT_REGISTERED     = Cint(713)
const CUDA_ERROR_HARDWARE_STACK_ERROR           = Cint(714)
const CUDA_ERROR_ILLEGAL_INSTRUCTION            = Cint(715)
const CUDA_ERROR_MISALIGNED_ADDRESS             = Cint(716)
const CUDA_ERROR_INVALID_ADDRESS_SPACE          = Cint(717)
const CUDA_ERROR_INVALID_PC                     = Cint(718)
const CUDA_ERROR_LAUNCH_FAILED                  = Cint(719)
const CUDA_ERROR_COOPERATIVE_LAUNCH_TOO_LARGE   = Cint(720)
const CUDA_ERROR_NOT_PERMITTED                  = Cint(800)
const CUDA_ERROR_NOT_SUPPORTED                  = Cint(801)
const CUDA_ERROR_UNKNOWN                        = Cint(999)
