# frozen_string_literal: true

describe FactoryBotRails::Railtie do
  describe "application reloading" do
    context "when a definition file has been updated" do
      it "reloads the factory definitions" do
        allow(FactoryBot).to receive(:reload)

        touch("factories.rb")
        reload_rails!

        expect(FactoryBot).to have_received(:reload).at_least(1).times
      end
    end

    context "when a file in a definition directory has been updated" do
      it "reloads the factory definitions" do
        allow(FactoryBot).to receive(:reload)

        touch("factories/definitions.rb")
        reload_rails!

        expect(FactoryBot).to have_received(:reload).at_least(1).times
      end
    end

    context "when the factory definitions have NOT been updated" do
      it "does NOT reload the factory definitions" do
        expect(FactoryBot).not_to receive(:reload)

        reload_rails!
      end
    end

    def touch(file)
      FileUtils.touch(Rails.root.join(file))
    end

    def reload_rails!
      Rails.application.reloader.reload!
      wait_for_rails_to_reload
    end

    def wait_for_rails_to_reload
      sleep 0.01
    end
  end
end
