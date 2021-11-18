# frozen_string_literal: true

# Public: Check the tokens of each File resource instance for a recurse
# true parameter and if found, record a warning about the potential
# performance impact.
#
# https://puppet.com/docs/puppet/latest/types/file.html#file-attribute-recurse
PuppetLint.new_check(:recurse_file) do
  def check
    resource_indexes.each do |resource|
      next unless resource[:type].value == 'file'

      param_tokens = resource[:param_tokens].select do |param_token|
        %w[recurse max_files].include? param_token.value
      end

      recurse = param_tokens.find do |t|
        t.value == 'recurse' and %w[true remote].include? t.next_code_token.next_code_token.value
      end

      next if recurse.nil?

      max_files = param_tokens.find do |t|
        t.value == 'max_files'
      end

      if max_files.nil?
        value_token = recurse.next_code_token.next_code_token
        notify(
          :warning,
          message: 'Unbounded recurse file resources can cause decreased performance. See "max_files"',
          line: value_token.line,
          column: value_token.column,
          token: value_token
        )
      elsif ['0', '-1'].include? max_files.next_code_token.next_code_token.value
        value_token = max_files.next_code_token.next_code_token
        notify(
          :warning,
          message: 'Disabling warnings in recurse file resources using "max_files" is not recommended',
          line: value_token.line,
          column: value_token.column,
          token: value_token
        )
      end
    end
  end
end
