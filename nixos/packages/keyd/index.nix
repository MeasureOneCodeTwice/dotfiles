{config, pkgs, ...}:
{
  # keyd has a bug where 'include' doesn't
  # resolve symlinks. 
  # Unfortunately, this means that we can't do imports
  # instead, we'll do the imports with nix and concatenate the files.
  services.keyd = {
    enable = true;
    keyboards = {
      # The name is just the name of the configuration file, it does not really matter
      default = {
	ids = [ "*" ]; 
	extraConfig = 
	builtins.readFile ./layout-config/dvorak +
	builtins.readFile ./layout-config/function-layer +
	''
          [global]
          default_layout = dvorak
          
          [dvorak:layout]
          capslock = layer(control)
          leftcontrol = capslock 
          
          rightalt = layer(function_layer)
	'';
      };
    };
  };
}
