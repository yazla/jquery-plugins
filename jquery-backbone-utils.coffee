# current element should be alreadt an item-list from jquery-item-list
$.fn.bind_collection = (collection) ->
    @load_items(collection.models)
    collection.on({
       'add' : @add_item
       'remove' : @remove_item
    }, @)

    @

$.fn.bind_model = (model) ->

    @update_properties = (properties) =>
        for property, value of properties
            prop_el = @find("[data = #{property}]")
            if prop_el.prop('value')? then prop_el.val(value) else prop_el.html(value)

    @update_properties(model.attributes)

    model.on('change', (m) => @update_properties(m.changedAttributes()) )

    @