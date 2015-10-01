require 'spec_helper'

describe Middleman::FragmentCaching::Cache do
  before(:each) { described_class.instance.clear! }

  describe '.store' do
    it 'is a Moneta file adapter instance' do
      expect(described_class.store.adapter).to be_a(Moneta::Adapters::File)
    end

    it 'stores a value' do
      described_class.store['foo'] = 'bar'
      expect(described_class.store['foo']).to be_eql('bar')
    end

    it 'removes a value' do
      described_class.store['foo'] = 'bar'
      expect(described_class.store['foo']).to be_eql('bar')

      described_class.store.delete :foo
      expect(described_class.store[:foo]).to be_nil
    end

    it 'return ordered stored keys' do
      described_class.store.clear

      described_class.store['foo'] = 'bar'
      described_class.store['baz'] = 'foo'

      expect(described_class.store.keys).to be_eql(%w(baz foo))
    end
  end

  describe '#find_or_set' do
    subject { described_class.instance }

    it 'caches the key / value' do
      result = subject.find_or_set(:foo) { 'bar' }
      expect(result).to be_eql('bar')

      result = subject.find_or_set(:foo) { 'other bar' }
      expect(result).to be_eql('bar')
    end

    it 'don\'t caches when the key is blank' do
      result = subject.find_or_set('') { 'bar' }
      expect(result).to be_eql('bar')

      result = subject.find_or_set(:foo) { 'other bar' }
      expect(result).to be_eql('bar')
    end
  end

  describe '#stored_keys' do
    subject { described_class.instance }

    it 'keeps accessed keys' do
      expect(subject.stored_keys).to be_empty

      subject.find_or_set(:foo) {}
      subject.find_or_set(:bar) {}
      subject.find_or_set(:bar) {}
      expect(subject.stored_keys.to_a).to be_eql(%w(foo bar))
    end
  end

  describe '#clear' do
    subject { described_class.instance }

    it 'remove only unusable keys' do
      subject.store.clear
      subject.stored_keys.clear

      subject.store['foo'] = 'bar'
      subject.find_or_set(:baz) { 'foo' }

      expect(subject.expires_keys).to be_eql(['foo'])

      subject.clear!

      expect(subject.store['foo']).to be_nil
      expect(subject.store['baz']).to be_eql('foo')
    end
  end
end
