// fan.cy
//
// Credit goes where it's due :)
//
// Adam Bell, 2014

// Don't want to inject these scripts multiple times :D
// I know this makes no sense, but no u
if (typeof fancySetup == 'undefined') {

    @import com.saurik.substrate.MS

    // kennytm / iphonedevwiki.net (http://networkpx.googlecode.com/svn/etc/std.cy, http://iphonedevwiki.net/index.php/Cycript_Tricks)
    NSLog_ = dlsym(RTLD_DEFAULT, "NSLog");
    NSLog = function() { var types = 'v', args = [], count = arguments.length; for (var i = 0; i != count; ++i) { types += '@'; args.push(arguments[i]); } new Functor(NSLog_, types).apply(null, args); };

    function CGPointMake(x, y) { return {x:x, y:y}; }
    function CGSizeMake(w, h) { return {width:w, height:h}; }
    function CGRectMake(x, y, w, h) { return {origin:CGPointMake(x,y), size:CGSizeMake(w, h)}; }
    function NSMakeRange(loc, len) { return {location:loc, length:len}; }

    function CGRectOffset(rect, dx, dy) { var copy = rect; copy.origin.x += dx; copy.origin.y += dy; return copy; }
    function CGRectInset(rect, dx, dy) { var copy = CGRectOffset(rect, dx, dy); copy.size.width -= (dx * 2.0); copy.size.height -= (dy * 2.0); return copy; }

    CFRangeMake = NSMakeRange;

    CGPointZero = CGPointMake(0,0);
    CGSizeZero = CGSizeMake(0,0);
    CGRectZero = CGRectMake(0,0,0,0);

    CGRect = new Type("{CGRect}");
    CGSize = new Type("{CGSize}");
    CGPoint = new Type("{CGPoint}");
    NSRange = new Type("{NSRange}");
    CFRange = new Type("{CFRange}");
    CGAffineTransform = new Type("{CGAffineTransform}");
    CATransform3D = new Type("{CATransform3D}");
    UIEdgeInsets = new Type("{UIEdgeInsets}");

    // Me
    CGAffineTransformIdentity = CGAffineTransformMakeScale(1,1);
    CATransform3DIdentity = CATransform3DMakeScale(1,1,1);

    function alert(message) {
        message = message.toString();
        var alert = [[UIAlertView alloc] initWithTitle:"cycript" message:message delegate:nil cancelButtonTitle:"OK" otherButtonTitles:nil];
        [alert show];

        return alert;
    }

    function methods(className) {
        var methods = new Array();
        var messages = className.messages;
        for (key in messages) {
            methods.push(key);
        }

        return methods.sort();
    }

    // Tags are probably not the nicest solutions, but objc_allocateClassPair explodes in cycript for some reason :(
    function unhighlight(view) {
        var tag = 0x9001;
        [[view viewWithTag:tag] removeFromSuperview];

        [view setNeedsDisplay];
    }

    function highlight(view) {
        if (![view isKindOfClass:[UIView class]])
            return;

        var tag = 0x9001; // IT'S OVER 9000!@#$!

        unhighlight(view);

        var highlight = [[UIView alloc] initWithFrame:view.bounds];
        highlight.backgroundColor = [UIColor clearColor];
        highlight.layer.borderWidth = 10;
        highlight.layer.borderColor = [[UIColor colorWithRed:0.37 green:0.76 blue:1.00 alpha:1.00] CGColor];
        highlight.tag = tag;
        highlight.clipsToBounds = NO;
        [view addSubview:highlight];

        [view setNeedsDisplay];
    }

    if ([view respondsToSelector:@selector(highlight)]) {
        UIView.prototype.highlight = function() {
            highlight(this);
        }
    }

    if ([view respondsToSelector:@selector(unhighlight)]) {
        UIView.prototype.unhighlight = function() {
            unhighlight(this);
        }
    }

    function setX(view, x) {
        var frame = view.frame;
        frame.origin.x = x;
    }

    function setY(view, y) {
        var frame = view.frame;
        frame.origin.y = y;
    }

    function setWidth(view, width) {
        var frame = view.frame;
        frame.size.width = width;
    }

    function setHeight(view, height) {
        var frame = view.frame;
        frame.size.height = height;
    }
}

fancySetup = 'Go Go Gadget Fancy';

// Disable printing above message ^
function nou() {}
nou();
