(function(factory) {
  'use strict';
  if (typeof define === 'function' && define.amd) {
    return define(['jquery'], function($) {
      return factory($, window);
    });
  } else if (typeof exports !== 'undefined') {
    return module.exports = factory(require('jquery'), window);
  } else {
    return factory(jQuery, window);
  }
})(function($, window) {
  'use strict';
  var CenterInlineBlock, Plugin, pluginName;
  pluginName = 'jquery-center-inline-block';
  CenterInlineBlock = function(element, options) {
    this.init(element, options);
  };
  CenterInlineBlock.prototype.init = function(element, options) {
    this.options = $.extend({}, {
      wrapper: "<div class='" + pluginName + "-wrapper' style='margin:0 auto; text-align:left'></div>",
      targetChildClass: null
    }, options);
    this.container = $(element);
    this.window = $(window);
    this.window_width = 0;
    this.child_width = null;
    this.appendWrapper();
    this.initWindowResizeEvent();
    return this.resize();
  };
  CenterInlineBlock.prototype.appendWrapper = function() {
    this.wrapper = $(this.options.wrapper);
    this.container.contents().appendTo(this.wrapper);
    return this.container.append(this.wrapper);
  };
  CenterInlineBlock.prototype.initWindowResizeEvent = function() {
    this.resizeID = this.window.data(pluginName + "-resize-id");
    if (!this.resizeID) {
      this.resizeID = 0;
    }
    this.resizeID++;
    this.window.data(pluginName + "-resize-id", this.resizeID);
    return this.window.on("resize." + pluginName + "-" + this.resizeID, this.onWindowResize.bind(this));
  };
  CenterInlineBlock.prototype.onWindowResize = function() {
    if (this.window_width !== this.window.width()) {
      this.window_width = this.window.width();
      clearTimeout(this.resizeTimeout);
      return this.resizeTimeout = setTimeout(this.resize.bind(this));
    }
  };
  CenterInlineBlock.prototype.resize = function() {
    var $childs, _this, capacity, new_width;
    if (this.container.is(':visible')) {
      this.wrapper.contents().each(function() {
        if (this.nodeType === 3 && !$.trim(this.nodeValue)) {
          return $(this).remove();
        }
      });
      if (this.child_width === null) {
        this.child_width = 0;
        _this = this;
        if (this.options.targetChildClass === null) {
          $childs = this.wrapper.children();
        } else {
          $childs = this.wrapper.find("." + this.options.targetChildClass);
        }
        $childs.each(function(i) {
          _this.child_width = $(this).outerWidth(true);
          return false;
        });
      }
      if (this.child_width > 0) {
        capacity = Math.floor(this.container.width() / this.child_width);
        if (capacity < 1) {
          capacity = 1;
        }
        new_width = capacity * this.child_width;
        if (this.wrapper.width() !== new_width) {
          return this.wrapper.width(new_width);
        }
      }
    }
  };
  CenterInlineBlock.prototype.destroy = function() {
    this.unbindWindowResize();
    this.removeWrapper();
    return this.container.data(pluginName, null);
  };
  CenterInlineBlock.prototype.removeWrapper = function() {
    return this.wrapper.contents().unwrap();
  };
  CenterInlineBlock.prototype.unbindWindowResize = function() {
    return this.window.unbind("resize." + pluginName + "-" + this.resizeID);
  };
  Plugin = function(option) {
    return this.each(function() {
      var $this, data, options;
      $this = $(this);
      data = $this.data(pluginName);
      if (data && typeof option === 'string') {
        return data[option]();
      } else if (data) {
        return data.resize();
      } else if (!/destroy/.test(option)) {
        options = typeof option === 'object' ? option : {};
        data = new CenterInlineBlock(this, options);
        return $this.data(pluginName, data);
      }
    });
  };
  return $.fn.centerInlineBlock = Plugin;
});
