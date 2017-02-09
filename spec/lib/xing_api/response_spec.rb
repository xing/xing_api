describe XingApi::Response do
  subject { XingApi::Response.new({ some: 'json' }.to_json, location: 'somewhere') }

  it 'behaves like the body hash' do
    expect(subject[:some]).to eq('json')
  end

  describe '#headers' do
    it 'returns the given headers' do
      expect(subject.headers).to eq(location: 'somewhere')
    end
  end
end
