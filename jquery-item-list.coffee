# options = {new_item_el}
$.fn.item_list = (options) ->

    @items_elements = []

    @load_items = (items) ->
        @empty()
        @add_item(item) for item in items

    @remove_item = (item) ->
        item_el = _.findWhere(@items_elements, {item})
        if item_el
            item_el.el.remove()
            @items_elements = _.without(@items_elements, item_el)

    @add_item = (item) ->
        @items_elements.push({
            item : item
            el : @append(options.new_item_el(item))
        })

    @refresh = () ->
        items = _.pluck(@items_elements, 'item')
        @load_items(items)


    @