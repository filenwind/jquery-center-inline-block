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
        @resize()
        return
    CenterInlineBlock.prototype.init = (element, options)->
        
        @options = $.extend({}, {
            wrapper:"<div class='#{pluginName}-wrapper' style='margin:0 auto; text-align:left'></div>"
        }, options)
        
        @container = $(element)
        @window = $(window)
        
        
        @window_width = 0
        @child_width = null
        
        @appendWrapper()
        @initWindowResizeEvent()
        
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
                @child_width = 0
                _this = @
                @wrapper.children().each((i)->
                    _this.child_width = $(@).outerWidth(true)
                    return false
                )
            
            
            if(@child_width > 0)
                capacity = Math.floor(@container.width() / @child_width)
                if(capacity < 1)
                    capacity = 1

                new_width = capacity*@child_width
                if(@wrapper.width() isnt new_width)
                    @wrapper.width(new_width)
                
                
            
    CenterInlineBlock.prototype.destroy = ()->
        @unbindWindowResize()
        @container.data(pluginName, null)
        
    CenterInlineBlock.prototype.unbindWindowResize = ()->
        @window.unbind("resize.#{pluginName}-#{@resizeID}")
        
    Plugin = (option)->
        
        @each(()->
            
            $this = $(this)
            data = $this.data(pluginName)
            
            if(data)
                if(typeof option == 'string')
                    data[option]()
            else if(!/destroy/.test(option))
                options = if typeof option is 'object' then option else {}
                $this.data(pluginName, new CenterInlineBlock(this, options))
            
        )
    
    $.fn.centerInlineBlock = Plugin
        
)