###
    DEPENDS ON SELECTABLE PLUGIN
    event - 'switch' - see on_switch in config
    el.switcher({
                switchers : 'li',
                selected_switcher_cls : 'active',
                switchables : 'div[tab]',
                selected_switchable_cls : 'class',
                switchables_container : <jquery>
                match_by : {attr : 'tab'},
                on_switch : (index, switcher, switchable) ->
            })
###

$.fn.switcher = (options) ->
    if not options.switchables_container
        console.log('switchables_container should be specified in options for switcher plugin')
        throw 'no switchables_container param for switcher plugin'

    do(options) =>
        opts = _.clone(options)

        _.defaults(opts, {
            selected_switchable_cls : ''
        })

        switchables = opts.switchables_container.selectable({
            item_selector : opts.switchables,
            selected_cls : opts.selected_switchable_cls
        })

        @.selectable({
            item_selector : opts.switchers,
            selected_cls : opts.selected_switcher_cls,
            on_selection_changed : (e, index, el) =>
                corresponding_swichable = null
                if _.isFunction(opts.match_by)
                    corresponding_swichable = opts.match_by(el)
                else
                    match_by_attr = opts.match_by.attr
                    corresponding_swichable = opts.switchables_container.find(opts.switchables + "[#{match_by_attr}='#{el.attr(match_by_attr)}']")

                if corresponding_swichable
                    switchables.select(corresponding_swichable)

                @trigger('switch', [index, el, corresponding_swichable])
        })

        if opts.on_switch
            @.bind('switch', opts)

    @