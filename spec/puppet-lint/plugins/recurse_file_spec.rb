# frozen_string_literal: true

require 'spec_helper'

describe 'recurse_file' do
  let(:msg) { 'recurse file resources can cause decreased performance' }

  context 'when recurse is enabled' do
    let(:code) { "file { 'foo': recurse => true }" }

    it 'onlies detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning(msg).on_line(1).in_column(26)
    end
  end

  context 'when recurse is disabled' do
    let(:code) { "file { 'foo': recurse => false }" }

    it 'does not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'when recurse is not defined' do
    let(:code) { "file { 'foo': }" }

    it 'does not detect any problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'with multi body file recurse selector' do
    let(:code) do
      <<-MANIFEST
          file {
            '/tmp/foo1':
              ensure => $foo ? { default => absent },
              recurse => true;
            '/tmp/foo2':
              recurse => true;
            '/tmp/foo3':
              recurse => true;
          }
      MANIFEST
    end

    it 'detects 3 problems' do
      expect(problems).to have(3).problems
    end

    it 'creates three warnings' do
      expect(problems).to contain_warning(sprintf(msg)).on_line(4).in_column(26)
      expect(problems).to contain_warning(sprintf(msg)).on_line(6).in_column(26)
      expect(problems).to contain_warning(sprintf(msg)).on_line(8).in_column(26)
    end
  end
end
