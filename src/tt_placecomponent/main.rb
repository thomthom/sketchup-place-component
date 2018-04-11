require 'sketchup.rb'

module TT::Plugins::PlaceComponent

  unless file_loaded?(__FILE__)
    menu = UI.menu('Plugins').add_submenu(EXTENSION[:name])
    UI.add_context_menu_handler { |context_menu|
      if self.valid_selection?
        context_menu.add_item('Place Component') {
          self.place_selected_component
        }
      end
    }
    file_loaded(__FILE__)
  end

  def self.valid_selection?
    model = Sketchup.active_model
    return false if model.nil?
    model.selection.size == 1 && model.selection.first.respond_to?(:definition)
  end

  def self.place_selected_component
    model = Sketchup.active_model
    definition = model.selection.first.definition
    model.place_component(definition, true)
  end

end # module
