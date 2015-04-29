require 'spec_helper'

describe TicTacToe::Human do
  describe 'when validating input' do
    let(:shell) { mock_shell }
    let(:human) { test_human(shell) }

    def mock_shell
      instance_double("TicTacToe::ConsoleShell").tap do |shell|
        allow(shell).to receive(:show_invalid_move_message)
        allow(shell).to receive(:show_move_error_message)
      end
    end

    def test_human(shell)
      TicTacToe::Human.new.tap do |h|
        h.set_shell(shell)
      end
    end

    def with(input:, expecting:)
      allow(shell).to receive(:prompt_move).and_return("#{input}\n")
      expect(human.get_move(nil)).to eq(expecting)
    end

    def ignores(input:)
      allow(shell).to receive(:prompt_move).and_return("#{input}\n", "1\n")
      expect(human.get_move(nil)).to eq(1)
    end

    it 'keeps reading until it gets a number' do
      allow(shell).to receive(:prompt_move).and_return("abcd\n", "def\n", "{1a\n", "1\n")
      expect(human.get_move(nil)).to eq(1)
    end

    it 'should only return a number between 0 and 8' do
      ignores(input: "-10")
      ignores(input: "-1")
      ignores(input: "9")
      ignores(input: "15")
      with(input: "0", expecting: 0)
      with(input: "4", expecting: 4)
      with(input: "8", expecting: 8)
    end

  end
end
