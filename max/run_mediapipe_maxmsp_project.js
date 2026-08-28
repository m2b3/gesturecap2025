const Max = require("max-api");
const { spawn } = require("child_process");
const path = require("path");

let tracker = null;

const TRACKER_PATH = path.resolve(
    __dirname,
    "..",
    "..",
    "..",
    "tracker",
    "doublehand_mp",
    "doublehand_mp"
);

Max.addHandler("camera_on", () => {

    if (tracker)
        return;

    tracker = spawn(TRACKER_PATH);

    tracker.stderr.on("data", (data) => {
        Max.post(data.toString());
    });

    tracker.on("close", () => {
        tracker = null;
    });
});

Max.addHandler("camera_off", () => {

    if (!tracker)
        return;

    tracker.kill();
    tracker = null;
});