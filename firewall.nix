{
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        80 # Example: allow HTTP
        443 # Example: allow HTTPS
        57537
        8080
      ];
      # allowedUDPPorts = [
      #   123 # Example: allow NTP
      # ];
      # allowedTCPPortRanges = [
      #   { from = 4000; to = 4007; }
      # ];
    };
}
