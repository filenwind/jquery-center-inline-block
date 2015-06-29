# jquery-center-inline-block
A jquery plugin for center inline block element, and last row align left.

### [Demo](http://filenwind.github.io/jquery-center-inline-block)

## Usage
```
<div id='container'>
    <div class="inline-box">1</div>
    <div class="inline-box">2</div>
    <div class="inline-box">3</div>
    ...
</div>
<script type="text/javascript">
    $('#container').centerInlineBlock(options)
</script>
```

## Installation

```
npm install jquery-center-inline-block
```


## Options
* **wrapper** - template for wrap container's contents
* **targetChildClass** - you can specified target child for count, It's useful when container have some element before childs


## Methods


**destroy**
```
$('#container').centerInlineBlock('destroy')
```

**resize** - trigger resize manual
```
$('#container').centerInlineBlock('resize')
```