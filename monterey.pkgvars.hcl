boot_wait_iso = "150s"
boot_keygroup_interval_iso = "150ms"
seeding_program = "none" # PublicSeed  CustomerSeed DeveloperSeed none
macos_version = "12.0"
#bootstrapper_script = [ "curl https://gist.githubusercontent.com/nycnewman/7d00f6327f89bc9faa8868f4513f0aaf/raw/b7eff6e7f06659c3044bf01dc4110c925145a42c/packer-testing -o vagrant-setup.sh","chmod +x vagrant-setup.sh", "sudo ./vagrant-setup.sh" ]
bootstrapper_script = [ "chmod +x ~/vagrant-setup.sh", "sudo ~/vagrant-setup.sh" ]


