###
    fires event - selection_changed (see on_selection_change config docs)
   $(el).selectable({
        item_selector : <selector which identifies the separate selectable item>,
        selected_cls : css class to be applied to the selecetd item
        on_selection_change : fn(e, index, el) - selection change event handler
   })
###
$.fn.selectable = (options) ->

    do(options) =>

        if options.on_selection_changed
            @.bind('selection_changed', options.on_selection_changed)

        @selected_index = null
        @selected_el = null

        @select = (selector_or_el_or_index) ->
            if _.isNumber(selector_or_el_or_index)
                el_to_select = $(@find(options.item_selector)[selector_or_el_or_index])
                @selected_index = selector_or_el_or_index
            else
                el_to_select = @find(selector_or_el_or_index)
                @selected_index = @find(options.item_selector).index(el_to_select)

            if el_to_select
                @selected_el = el_to_select
                @find(options.item_selector).removeClass(options.selected_cls) #deselect all items
                el_to_select.addClass(options.selected_cls) # select current item
                @trigger('selection_changed', [@selected_index, el_to_select])

        @select_nearest_to_index = (index) =>
            elements = @find(options.item_selector)
            el = elements[index] or elements[index-1] or elements[index+1]
            if el
                @select(el)

        @.click((e) =>
            target = $(e.target)
            if target.is(options.item_selector)
                @select(target)
            else
                parent = target.parentsUntil(@, options.item_selector).first()
                if parent.length
                    @select(parent)
        )
    @