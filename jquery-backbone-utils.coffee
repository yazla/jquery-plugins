# current element should be alreadt an item-list from jquery-item-list
$.fn.bind_collection = (collection) ->
    @load_items(collection.models)
    collection.on({
       'add' : @add_item
       'remove' : @remove_item
    }, @)

$.fn.bind_model = (model) ->

    @update_properties = (properties) ->
        @find("[data = #{property}]").update(value) for property, value in properties

    @update_properties(model.attributes)

    model.on('change', (m) => @update_properties(m.changedAttributes))