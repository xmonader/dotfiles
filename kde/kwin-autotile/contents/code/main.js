// i3-like auto-tiling for KDE Plasma 6
// 1 window  = fullscreen
// 2 windows = 50/50 left/right
// 3+ windows = master left, stacked right

var masterRatio = 0.5;

function isTileable(window) {
    return window.normalWindow
        && window.moveable
        && window.resizeable
        && !window.minimized
        && !window.fullScreen
        && !window.skipTaskbar;
}

function getTileableWindows(desktop, output) {
    var windows = [];
    var all = workspace.windowList();
    for (var i = 0; i < all.length; i++) {
        var w = all[i];
        if (!isTileable(w)) continue;
        if (w.output !== output) continue;
        var desktops = w.desktops;
        for (var d = 0; d < desktops.length; d++) {
            if (desktops[d] === desktop) {
                windows.push(w);
                break;
            }
        }
    }
    return windows;
}

function retile() {
    var current = workspace.activeWindow;
    if (!current) return;

    var desktop = current.desktops[0];
    var output = current.output;
    var area = workspace.clientArea(0, output, desktop);
    var windows = getTileableWindows(desktop, output);
    var n = windows.length;

    if (n === 0) return;

    if (n === 1) {
        windows[0].frameGeometry = {
            x: area.x,
            y: area.y,
            width: area.width,
            height: area.height
        };
        return;
    }

    var masterWidth = Math.floor(area.width * masterRatio);
    windows[0].frameGeometry = {
        x: area.x,
        y: area.y,
        width: masterWidth,
        height: area.height
    };

    var stackCount = n - 1;
    var stackWidth = area.width - masterWidth;
    var stackHeight = Math.floor(area.height / stackCount);

    for (var i = 1; i < n; i++) {
        var yOffset = (i - 1) * stackHeight;
        var h = (i === n - 1) ? (area.height - yOffset) : stackHeight;
        windows[i].frameGeometry = {
            x: area.x + masterWidth,
            y: area.y + yOffset,
            width: stackWidth,
            height: h
        };
    }
}

function watchWindow(window) {
    window.minimizedChanged.connect(function () {
        retile();
    });
    window.fullScreenChanged.connect(function () {
        retile();
    });
}

workspace.windowAdded.connect(function (window) {
    if (isTileable(window)) {
        watchWindow(window);
        retile();
    }
});

workspace.windowRemoved.connect(function () {
    retile();
});

workspace.currentDesktopChanged.connect(function () {
    retile();
});

// Watch existing windows
var existing = workspace.windowList();
for (var i = 0; i < existing.length; i++) {
    if (isTileable(existing[i])) {
        watchWindow(existing[i]);
    }
}
