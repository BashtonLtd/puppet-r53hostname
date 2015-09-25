require 'spec_helper'
describe 'r53hostname' do

  context 'with defaults for all parameters' do
    it { should contain_class('r53hostname') }
  end
end
