describe Nanoc::Int::Compiler do
  let(:compiler) do
    described_class.new(
      site,
      compiled_content_cache: compiled_content_cache,
      checksum_store: checksum_store,
      rule_memory_store: rule_memory_store,
      action_provider: action_provider,
      dependency_store: dependency_store,
      outdatedness_checker: outdatedness_checker,
      reps: reps,
    )
  end

  let(:checksum_store)         { :__irrelevant_checksum_store }
  let(:rule_memory_store)      { :__irrelevant_rule_memory_store }
  let(:dependency_store)       { :__irrelevant_dependency_store }
  let(:reps)                   { :__irrelevant_reps }

  let(:outdatedness_checker) { double(:outdatedness_checker) }
  let(:action_provider) { double(:action_provider) }

  let(:compiled_content_cache) { Nanoc::Int::CompiledContentCache.new }

  describe '#compile_rep' do
    let(:rep) { Nanoc::Int::ItemRep.new(item, :default) }
    let(:item) { Nanoc::Int::Item.new('<%= 1 + 2 %>', {}, '/hi.md') }

    subject { compiler.send(:compile_rep, rep) }

    let(:site) do
      Nanoc::Int::Site.new(
        config: config,
        code_snippets: code_snippets,
        items: items,
        layouts: layouts,
      )
    end

    let(:config) { Nanoc::Int::Configuration.new }
    let(:items) { [item] }
    let(:layouts) { [] }
    let(:code_snippets) { [] }

    let(:memory) do
      [
        Nanoc::Int::RuleMemoryActions::Filter.new(:erb, {}),
      ]
    end

    before do
      expect(outdatedness_checker).to receive(:outdated?).with(rep).and_return(true)
      expect(action_provider).to receive(:memory_for).with(rep).and_return(memory)
    end

    it 'works' do
      subject
      expect(rep.snapshot_contents[:last].string).to eql('3')
    end
  end
end
