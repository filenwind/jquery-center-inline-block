((factory)->
    'use strict'
    
    if (typeof define is 'function' and define.amd)
        define(['jquery'], ($) ->
            factory($, window)
        )
    else if (typeof exports isnt 'undefined') 
        module.exports = factory(require('jquery'), window)
    else
        factory(jQuery, window)
    
    
)(($, window)->
    'use strict'
    
    pluginName = 'jquery-center-inline-block'
    
    CenterInlineBlock = (element, options)->
        @init(element, options)
        return
    CenterInlineBlock.prototype.init = (element, options)->
        @options = $.extend({}, {
            wrapper:"<div class='#{pluginName}-wrapper' style='margin:0 auto; text-align:left'></div>"
            targetChildClass: null
            targetChildSelector: null
            minChildWidth: null
        }, options)
        
        @container = $(element)
        @window = $(window)
        
        @window_width = 0
        @child_width = null
        
        @appendWrapper()
        @initWindowResizeEvent()
        @resize()
        
    CenterInlineBlock.prototype.appendWrapper = ()->
        @wrapper = $(@options.wrapper)
        @container.contents().appendTo(@wrapper)
        @container.append(@wrapper)
    
    CenterInlineBlock.prototype.initWindowResizeEvent = ()->
        @resizeID = @window.data("#{pluginName}-resize-id")
        if(!@resizeID)
            @resizeID = 0
        @resizeID++
        
        @window.data("#{pluginName}-resize-id", @resizeID)
        
        @window.on("resize.#{pluginName}-#{@resizeID}", @onWindowResize.bind(@))
            
    CenterInlineBlock.prototype.onWindowResize = ()->
        if(@window_width isnt @window.width())
            @window_width = @window.width()
            
            clearTimeout(@resizeTimeout)
            @resizeTimeout = setTimeout(@resize.bind(@))
            
    CenterInlineBlock.prototype.resize = ()->
        if(@container.is(':visible'))
            @wrapper.contents().each(()->
                if(@nodeType is 3 and !$.trim(@nodeValue))
                    $(@).remove()
            )
            
            
            if(@child_width is null)
                @initChildWidth()
                
            if(@child_width isnt null and @child_width > 0)
                capacity = Math.floor(@container.width() / @child_width)
                if(capacity < 1)
                    capacity = 1

                new_width = capacity*@child_width
                if(@wrapper.width() isnt new_width)
                    @wrapper.width(new_width)
                    
    CenterInlineBlock.prototype.initChildWidth = ()->
        
        if(@options.targetChildClass isnt null)
            $childs = @wrapper.find(".#{@options.targetChildClass}")
        else if(@options.targetChildSelector isnt null)
            $childs = @wrapper.find(@options.targetChildSelector)
        else
            $childs = @wrapper.children()
        
        
        if($childs.size())
            @child_width = $childs.eq(0).outerWidth(true)
        
        
        if(@options.minChildWidth is null)
        else if(@child_width is null or @child_width < @options.minChildWidth)
            @child_width = @options.minChildWidth
        
        
    CenterInlineBlock.prototype.destroy = ()->
        @unbindWindowResize()
        @removeWrapper()
        @container.data(pluginName, null)
        
    CenterInlineBlock.prototype.removeWrapper = ()->
        @wrapper.contents().unwrap()
        
    CenterInlineBlock.prototype.unbindWindowResize = ()->
        @window.unbind("resize.#{pluginName}-#{@resizeID}")
                
    Plugin = (option)->
        @each(()->
            
            $this = $(@)
            data = $this.data(pluginName)
            if(data and typeof option is 'string')
                data[option]()
            else if(data)
                data.resize()
            else if(!/destroy/.test(option))
                options = if typeof option is 'object' then option else {}
                data = new CenterInlineBlock(@, options)
                $this.data(pluginName, data)
        )
    
    $.fn.centerInlineBlock = Plugin
        
)