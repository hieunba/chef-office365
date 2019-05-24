default['office365']['language'] = 'en-us'
default['office365']['timeout'] = 1500

default['office365']['config']['channel'] = 'Monthly'
default['office365']['config']['edition'] = if node['kernel']['machine'] =~ /x86_64/
                                              64
                                            else
                                              32
                                            end
default['office365']['config']['product_id'] = 'O365BusinessRetail'
default['office365']['config']['display_level'] = 'None'
default['office365']['config']['auto_activate'] = 0
default['office365']['config']['pin_icons_to_taskbar'] = 'FALSE'

default['officedeploymenttool']['source'] = 'https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_11617-33601.exe'
default['officedeploymenttool']['checksum'] = 'e9545300ebf4df13272cf826d5a82c79afeacf8a0fc64281bbe18c0687acd3da'
