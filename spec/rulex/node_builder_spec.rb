require 'spec_helper.rb'
describe Rulex::NodeBuilder do

  class Builder 
    include Rulex::NodeBuilder
  end

  def new_builder
    Builder.new
  end

  describe '#build_command' do
    it 'raises RuntimeError if no suiting behavior is found' do
      expect{new_builder.write_command "flip"}.to raise_error RuntimeError
    end
  end

  it 'allows adding String -> Hash behaviors' do
    builder = new_builder
    builder.add_behavior("flip", {type: :text, text: "flop"})
    expect(builder.build_command "flip").to eq(type: :text, text: "flop")
  end

  it 'allows adding Regexp -> Hash behaviors' do
    builder = new_builder
    builder.add_behavior(/.lip/, {type: :text, text: "flop"})
    expect(builder.build_command "flip").to eq(type: :text, text: "flop")
  end

  it 'allows adding String -> (lambda::Hash -> String) behaviors' do
    builder = new_builder
    builder.add_behavior("flip", lambda { |s| {type: :text, text: s.gsub(/i/,'o')}})
    expect(builder.build_command "flip").to eq(type: :text, text: "flop")
  end

  it 'allows adding Regexp -> (lambda::String -> Hash) behaviors' do
    builder = new_builder
    builder.add_behavior(/.lip/, lambda { |s| {type: :text, text: s.gsub(/i/,'o')}})
    expect(builder.build_command "flip").to eq(type: :text, text: "flop")
  end

  it 'allows adding [Regexp | String] -> SuperLambda' do
    builder = new_builder
    sl = Rulex::SuperLambda.new(->(s){{type: :text, text: "1 arg"}}, ->(s,t) {{type: :text, text: "2 args"}})
    builder.add_behavior("flip", sl)
    expect(builder.build_command "flip").to eq(type: :text, text: "1 arg")
    expect(builder.build_command("flip","flop")).to eq(type: :text, text: "2 args")
  end
end
