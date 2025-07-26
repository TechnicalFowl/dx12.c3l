module dxgi;

////////////////////////////////////////////////////////////////////////////////
// Constants
////////////////////////////////////////////////////////////////////////////////

const DXGI_CREATE_FACTORY_DEBUG = 0x1;

const DXGI_CPU_ACCESS_NONE = 0;
const DXGI_CPU_ACCESS_DYNAMIC = 1;
const DXGI_CPU_ACCESS_READ_WRITE = 2;
const DXGI_CPU_ACCESS_SCRATCH = 3;
const DXGI_CPU_ACCESS_FIELD = 15;

const DXGI_RESOURCE_PRIORITY_MINIMUM = 0x28000000;
const DXGI_RESOURCE_PRIORITY_LOW = 0x50000000;
const DXGI_RESOURCE_PRIORITY_NORMAL = 0x78000000;
const DXGI_RESOURCE_PRIORITY_HIGH = 0xa0000000;
const DXGI_RESOURCE_PRIORITY_MAXIMUM = 0xc8000000;

const DXGI_MAP_READ	= 1;
const DXGI_MAP_WRITE = 2;
const DXGI_MAP_DISCARD = 4;

const DXGI_MAX_SWAP_CHAIN_BUFFERS = 16;

const DXGI_ENUM_MODES_STEREO = 4;
const DXGI_ENUM_MODES_DISABLED_STEREO = 8;

const DXGI_SHARED_RESOURCE_READ = 0x80000000;
const DXGI_SHARED_RESOURCE_WRITE = 1;