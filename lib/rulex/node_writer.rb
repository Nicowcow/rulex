module Rulex
  class NodeWriter

    def initialize
      @rules = []
    end

    def add_type(type, ret)
      @rules.push(type: type, ret: ret)
    end

    def snippet_for(node)
      type = node[:type]
      rule = nil

      @rules.each do |r|
        next unless r[:type] === type
        rule = r
      end

      raise RuntimeError, "No rule found" unless rule

      ret = rule[:ret]

      if Proc === ret
        ret.call(id)
      else
        ret
      end
    end
  end
end
