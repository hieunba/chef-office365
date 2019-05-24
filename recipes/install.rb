#
# Cookbook:: office365
# Recipe:: install
#
# Copyright:: 2019, Nghiem Ba Hieu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
download_cache_path = Chef::Config[:file_cache_path]
extract_cache_path = Chef::Util::PathHelper.join(download_cache_path, 'officedeploymenttool')
download_file_path = Chef::Util::PathHelper.join(download_cache_path, 'officedeploymnttool.exe')
deploy_file_path = Chef::Util::PathHelper.join(extract_cache_path, 'setup.exe')
configuration_template = Chef::Util::PathHelper.join(download_cache_path, 'OfficeDeploymentConfiguration.xml')

directory extract_cache_path

deploy_config = {}
deploy_config['edition'] = {
  edition: node['office365']['edition'],
  channel: node['office365']['channel']
}

template configuration_template do
  source 'configuration.xml.erb'
  variables(
    edition: deploy_config[:edition],
    channel: deploy_config[:channel]
  )
end

remote_file download_file_path do
  source node['officedeploymenttool']['source']
  checksum node['officedeploymenttool']['checksum'] if node['officedeploymenttool']['checksum']
  backup false
  action :create
end

execute 'extract office deployment tool' do
  command "#{download_file_path} /quiet /extract:#{extract_cache_path}"
  not_if { ::File.exist?(deploy_file_path) }
end

execute 'seeding office deployment' do
  command "#{deploy_file_path} /download #{configuration_template}"
  cwd extract_cache_path
  not_if { ::File.exist?(::File.join(extract_cache_path, 'Office')) }
end

language = node['office365']['language'] || 'en-us'
package_name = 'Microsoft Office 365 '

package_name += case node['office365']['config']['product_id']
                when 'O365BusinessRetail' then "Business - #{language}"
                when 'O365ProPlusRetail' then "ProPlus - #{language}"
                end

deploy_options = "/configure #{configuration_template}"

windows_package "Microsoft Office 365 #{language}" do
  package_name package_name
  source deploy_file_path
  action :install
  installer_type :custom
  options deploy_options
  timeout node['office365']['timeout']
end
