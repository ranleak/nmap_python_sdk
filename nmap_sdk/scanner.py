import os
import subprocess
import shlex

class NmapScanner:
    def __init__(self):
        # Locate the bundled binary relative to this python file
        base_dir = os.path.dirname(os.path.abspath(__file__))
        self.nmap_path = os.path.join(base_dir, 'bin', 'nmap')
        
        if not os.path.exists(self.nmap_path):
            raise FileNotFoundError(
                f"Bundled Nmap binary not found at {self.nmap_path}. "
                "Ensure the package was built correctly."
            )

    def scan(self, target: str, arguments: str = "-sn"):
        """
        Executes a scan against a target using the bundled Nmap binary.
        """
        # Safely split the arguments string into a list
        args_list = shlex.split(arguments)
        
        # Build the command array
        command = [self.nmap_path] + args_list + [target]
        
        try:
            result = subprocess.run(
                command, 
                capture_output=True, 
                text=True, 
                check=True
            )
            return result.stdout
        except subprocess.CalledProcessError as e:
            raise RuntimeError(f"Nmap scan failed:\n{e.stderr}") from e