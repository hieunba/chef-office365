# # encoding: utf-8

# Inspec test for recipe office365::install

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

return unless os.windows?

describe file('C:/Program Files/Microsoft Office/root/Office16/WINWORD.exe') do
  it { should exist }
end

describe file('C:/Program Files/Microsoft Office/root/Office16/EXCEL.exe') do
  it { should exist }
end

describe file('C:/Program Files/Microsoft Office/root/Office16/POWERPNT.exe') do
  it { should exist }
end

describe file('C:/Program Files/Microsoft Office/root/Office16/OUTLOOK.exe') do
  it { should exist }
end

describe file('C:/Program Files/Microsoft Office/root/Office16/MSPUB.exe') do
  it { should exist }
end

describe file('C:/Program Files/Microsoft Office/root/Office16/lync.exe') do
  it { should exist }
end

describe file('C:/Program Files/Microsoft Office/root/Office16/ONENOTE.exe') do
  it { should exist }
end
