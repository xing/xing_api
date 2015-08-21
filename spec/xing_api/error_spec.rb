describe XingApi::Error do
  describe '#errors' do
    subject { described_class.new(nil, nil, nil, errors) }

    context 'when provided' do
      let(:errors) { ['some error'] }

      it 'returns the errors' do
        expect(subject.errors).to eq(errors)
      end
    end

    context 'when nil' do
      let(:errors) { nil }

      it 'returns an empty list' do
        expect(subject.errors).to eq([])
      end
    end
  end

  describe '#message' do
    let(:errors) { [{ field: 'city', reason: 'TOO_SHORT' }] }
    subject { described_class.new(403, 'INVALID_PARAMETERS', 'invalid parameter', errors) }

    it 'returns all object information' do
      expected = '403 - INVALID_PARAMETERS - invalid parameter - [{:field=>"city", :reason=>"TOO_SHORT"}]'
      expect(subject.message).to eq(expected)
    end
  end
end
