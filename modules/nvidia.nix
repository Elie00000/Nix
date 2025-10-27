{ config, ... }: {
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.legacy_535;
    };

    # Enable OpenGL
    hardware.graphics = {
        enable = true;
    };
    # Prime
    hardware.nvidia.prime = {
        sync.enable = true;
        intelBusId = "PCI:0:2:0";     
        nvidiaBusId = "PCI:1:0:0";     
    };
}