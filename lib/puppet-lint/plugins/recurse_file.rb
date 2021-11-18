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
        param_token.value == 'recurse'
      end
      param_tokens.each do |param_token|
        value_token = param_token.next_code_token.next_code_token

        next unless value_token.value == 'true'

        notify(
          :warning,
          message: 'recurse file resources can cause decreased performance',
          line: value_token.line,
          column: value_token.column,
          token: value_token
        )
      end
    end
  end
end
