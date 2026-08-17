{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 2,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 34.0, 95.0, 1092.0, 853.0 ],
        "boxes": [
            {
                "box": {
                    "bubble": 1,
                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                    "bubble_outlinecolor": [ 0.0196078431372549, 0.0196078431372549, 0.0196078431372549, 1.0 ],
                    "bubbleside": 3,
                    "bubbletextmargin": 6,
                    "fontsize": 12.0,
                    "id": "obj-21",
                    "linecount": 4,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 675.0, 308.5454514026642, 219.0, 66.0 ],
                    "presentation_linecount": 5,
                    "text": "Tracker Launch Mode\n\n0 = Development (Repository)\n1 = Standalone (Application Bundle)",
                    "textcolor": [ 0.11372549019607843, 0.11372549019607843, 0.11372549019607843, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "bubble": 1,
                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                    "bubble_outlinecolor": [ 0.0196078431372549, 0.0196078431372549, 0.0196078431372549, 1.0 ],
                    "bubbleside": 3,
                    "bubbletextmargin": 6,
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "linecount": 4,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 997.8181710243225, 77.0, 203.0, 66.0 ],
                    "presentation_linecount": 4,
                    "text": "Shutdown Cleanup\n\nAutomatically stops the tracker\nand releases the camera on exit.",
                    "textcolor": [ 0.11372549019607843, 0.11372549019607843, 0.11372549019607843, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 1213.6363520622253, 99.0, 63.0, 22.0 ],
                    "text": "closebang"
                }
            },
            {
                "box": {
                    "bubble": 1,
                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                    "bubbleside": 0,
                    "bubbletextmargin": 6,
                    "fontsize": 30.0,
                    "id": "obj-25",
                    "linecount": 6,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1458.3254749178886, 1052.2727172374725, 358.0, 262.0 ],
                    "text": "Live Hand Visualizer\n\nPlease be patient.\nThe preview window may take approximately 30 seconds to open.\n",
                    "textcolor": [ 0.0, 0.0, 0.0, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "bubble": 1,
                    "bubble_bgcolor": [ 0.8705882352941177, 0.6431372549019608, 0.6431372549019608, 0.57 ],
                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                    "bubbleside": 2,
                    "bubbletextmargin": 6,
                    "fontsize": 12.0,
                    "id": "obj-20",
                    "linecount": 7,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 0.0, 0.0, 768.181811, 121.0 ],
                    "text": "GestureCap Tracker Test\n\nThis patch demonstrates how to launch and control the MediaPipe tracker from Max/MSP.\n\nUse Development mode when running from the GestureCap repository.\n\nUse Standalone mode when running from a compiled Collective or Application.",
                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "bubble": 1,
                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                    "bubble_outlinecolor": [ 0.0196078431372549, 0.0196078431372549, 0.0196078431372549, 1.0 ],
                    "bubbleside": 3,
                    "bubbletextmargin": 6,
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 288.63636088371277, 432.40908670425415, 205.0, 39.0 ],
                    "text": "available devices and device formats",
                    "textcolor": [ 0.11372549019607843, 0.11372549019607843, 0.11372549019607843, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "id": "obj-29",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 1484.0908949375153, 549.9999947547913, 48.0, 22.0 ],
                    "text": "del 100"
                }
            },
            {
                "box": {
                    "id": "obj-65",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1570.4545304775238, 549.9999947547913, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-63",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 1570.4545304775238, 581.8181762695312, 63.0, 22.0 ],
                    "text": "qmetro 16"
                }
            },
            {
                "box": {
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 1484.0908949375153, 511.3636314868927, 34.0, 22.0 ],
                    "text": "sel 0"
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "clear", "clear" ],
                    "patching_rect": [ 1484.0908949375153, 581.8181762695312, 71.0, 22.0 ],
                    "text": "t clear clear"
                }
            },
            {
                "box": {
                    "id": "obj-60",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1670.4545295238495, 654.5454483032227, 102.0, 22.0 ],
                    "text": "r Visu_RightHand"
                }
            },
            {
                "box": {
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1570.4545304775238, 654.5454483032227, 94.0, 22.0 ],
                    "text": "r Visu_LeftHand"
                }
            },
            {
                "box": {
                    "border": 0,
                    "filename": "mediapipe_handdraw.js",
                    "id": "obj-35",
                    "maxclass": "jsui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1484.0908949375153, 727.2727203369141, 302.46915996074677, 296.29631996154785 ],
                    "presentation": 1,
                    "presentation_rect": [ 1.600000023841858, 4.966662876037589, 484.80000722408295, 487.8333444672546 ]
                }
            },
            {
                "box": {
                    "checkedcolor": [ 0.6274509803921569, 0.9686274509803922, 0.11764705882352941, 1.0 ],
                    "id": "obj-13",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1484.0908949375153, 163.63636207580566, 172.0, 172.0 ],
                    "uncheckedcolor": [ 0.8705882352941177, 0.1568627450980392, 0.1568627450980392, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-10",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 902.272718667984, 429.54545044898987, 29.5, 22.0 ],
                    "text": "+ 1"
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 902.272718667984, 329.5454514026642, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 902.272718667984, 506.818176984787, 106.03448832035065, 22.0 ],
                    "text": "gate 2"
                }
            },
            {
                "box": {
                    "color": [ 1.0, 0.4117647058823529, 0.01568627450980392, 1.0 ],
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 413.6363596916199, 222.72727060317993, 58.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "color": [ 1.0, 0.4117647058823529, 0.01568627450980392, 1.0 ],
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 77.27272653579712, 234.0909068584442, 70.0, 22.0 ],
                    "text": "loadmess 0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "id": "obj-128",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "clear", "clear" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 134.0, 167.0, 389.0, 300.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 132.5, 27.0, 23.0 ],
                                    "text": "iter"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "clear" ],
                                    "patching_rect": [ 151.0, 132.5, 46.0, 23.0 ],
                                    "text": "t clear"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "clear" ],
                                    "patching_rect": [ 302.0, 131.5, 46.0, 23.0 ],
                                    "text": "t clear"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "id": "obj-27",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 201.0, 155.5, 107.0, 23.0 ],
                                    "text": "prepend append"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "id": "obj-28",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 201.0, 132.5, 27.0, 23.0 ],
                                    "text": "iter"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "id": "obj-32",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 155.5, 107.0, 23.0 ],
                                    "text": "prepend append"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "id": "obj-33",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 3,
                                    "outlettype": [ "", "", "" ],
                                    "patching_rect": [ 50.0, 100.0, 141.0, 23.0 ],
                                    "text": "route vdevlist formatlist"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 40.0, 25.0, 25.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-5",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 95.5, 236.5, 25.0, 25.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-13",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 246.5, 236.5, 25.0, 25.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-33", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-32", 0 ],
                                    "source": [ "obj-21", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-23", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "source": [ "obj-24", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "source": [ "obj-27", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-27", 0 ],
                                    "source": [ "obj-28", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-32", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "order": 1,
                                    "source": [ "obj-33", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "midpoints": [ 59.5, 128.5, 160.5, 128.5 ],
                                    "order": 0,
                                    "source": [ "obj-33", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "midpoints": [ 120.5, 124.5, 311.5, 124.5 ],
                                    "order": 0,
                                    "source": [ "obj-33", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-28", 0 ],
                                    "midpoints": [ 120.5, 124.5, 210.5, 124.5 ],
                                    "order": 1,
                                    "source": [ "obj-33", 1 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 506.818176984787, 397.7272689342499, 170.0, 23.0 ],
                    "text": "p vdev/format"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "id": "obj-187",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 654.5454483032227, 506.818176984787, 63.0, 23.0 ],
                    "text": "format $1"
                }
            },
            {
                "box": {
                    "id": "obj-189",
                    "items": [ "NV12 - 420YpCbCr8BiPlanar - 1920 x 1080", ",", "NV12 - 420YpCbCr8BiPlanar - 1280 x 720", ",", "NV12 - 420YpCbCr8BiPlanar - 1080 x 1920", ",", "NV12 - 420YpCbCr8BiPlanar - 1760 x 1328", ",", "NV12 - 420YpCbCr8BiPlanar - 640 x 480", ",", "NV12 - 420YpCbCr8BiPlanar - 1328 x 1760", ",", "NV12 - 420YpCbCr8BiPlanar - 1552 x 1552" ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 654.5454483032227, 440.90908670425415, 211.5, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "id": "obj-233",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 506.818176984787, 506.818176984787, 73.0, 23.0 ],
                    "text": "vdevice $1"
                }
            },
            {
                "box": {
                    "id": "obj-237",
                    "items": "FaceTime HD Camera",
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 506.818176984787, 440.90908670425415, 145.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "id": "obj-243",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 413.6363596916199, 286.3636336326599, 72.0, 23.0 ],
                    "text": "getvdevlist"
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "id": "obj-253",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "jit_matrix", "" ],
                    "patching_rect": [ 413.6363596916199, 318.1818151473999, 113.0, 23.0 ],
                    "text": "jit.grab 320 240"
                }
            },
            {
                "box": {
                    "id": "obj-152",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1136.3636255264282, 606.8181760311127, 227.0, 22.0 ],
                    "saved_object_attributes": {
                        "autostart": 0,
                        "defer": 0,
                        "node_bin_path": "",
                        "npm_bin_path": "",
                        "watch": 0
                    },
                    "text": "node.script run_mediapipe_standalone.js",
                    "textfile": {
                        "filename": "run_mediapipe_standalone.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "bubble": 1,
                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                    "bubbleside": 0,
                    "bubbletextmargin": 6,
                    "fontsize": 12.0,
                    "id": "obj-150",
                    "linecount": 13,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 909.0909004211426, 636.3636302947998, 193.0, 202.0 ],
                    "text": "Development Script (Max Patch)\n\nThis script launches the PyInstaller-packaged tracker directly from the GestureCap repository.\n\nUse this version while developing and testing inside Max.\n\nThe tracker executable must be available in the repository folder specified in TRACKER_PATH.",
                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "bubble": 1,
                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                    "bubbleside": 0,
                    "bubbletextmargin": 6,
                    "fontsize": 12.0,
                    "id": "obj-138",
                    "linecount": 29,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1136.3636255264282, 636.3636302947998, 225.51001453399658, 416.0 ],
                    "text": "Standalone Script\n\nThis script launches the PyInstaller-packaged tracker from a macOS standalone application.\n\nBefore running:\n\n1. Build a Collective or Standalone Application from the Max project.\n2. Copy the complete tracker folder into the application bundle.\n\nTo access the application bundle:\n\n1. Right-click on YourApp.app\n2. Select \"Show Package Contents\"\n3. Open:\n   Contents → Resources\n4. Copy the tracker folder into Resources\n\nExpected structure:\n\nYourApp.app\n└── Contents\n    └── Resources\n        └── tracker\n            └── doublehand_mp",
                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "bubble_outlinecolor": [ 0.0196078431372549, 0.0196078431372549, 0.0196078431372549, 1.0 ],
                    "id": "obj-229",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 154.59458768367767, 401.62160366773605, 60.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 256.8965651988983, 540.5689949989319, 60.0, 20.0 ],
                    "text": "OSC Port",
                    "textcolor": [ 0.11372549019607843, 0.11372549019607843, 0.11372549019607843, 1.0 ]
                }
            },
            {
                "box": {
                    "bubble_outlinecolor": [ 0.0196078431372549, 0.0196078431372549, 0.0196078431372549, 1.0 ],
                    "id": "obj-228",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 281.63636088371277, 283.8181791305542, 81.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 167.97754150629044, 540.5689949989319, 81.0, 20.0 ],
                    "text": "OSC Pipeline",
                    "textcolor": [ 0.11372549019607843, 0.11372549019607843, 0.11372549019607843, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-205",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 77.27272653579712, 440.90908670425415, 46.0, 22.0 ],
                    "text": "port $1"
                }
            },
            {
                "box": {
                    "id": "obj-204",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 77.27272653579712, 488.63635897636414, 97.0, 22.0 ],
                    "text": "udpreceive 9000"
                }
            },
            {
                "box": {
                    "id": "obj-202",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 77.27272653579712, 352.27272391319275, 45.0, 22.0 ],
                    "text": "t 11111"
                }
            },
            {
                "box": {
                    "id": "obj-201",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 77.27272653579712, 322.7272696495056, 34.0, 22.0 ],
                    "text": "sel 0"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.0, 0.0, 0.0, 1.0 ],
                    "activeslidercolor": [ 0.36475205421447754, 0.41966676712036133, 0.8861922025680542, 0.0 ],
                    "bordercolor": [ 0.7, 0.82, 0.95, 0.5 ],
                    "focusbordercolor": [ 0.7, 0.82, 0.95, 1.0 ],
                    "fontsize": 16.0,
                    "id": "obj-199",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 77.27272653579712, 399.99999618530273, 68.0, 23.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 261.6465651988983, 567.9157756567001, 50.5, 23.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activeslidercolor": {
                            "expression": ""
                        },
                        "bordercolor": {
                            "expression": ""
                        },
                        "focusbordercolor": {
                            "expression": ""
                        },
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [ 11111 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "live.numbox[91]",
                            "parameter_mmax": 65535.0,
                            "parameter_mmin": 4.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "live.numbox[37]",
                            "parameter_type": 0,
                            "parameter_unitstyle": 0
                        }
                    },
                    "textcolor": [ 0.592, 0.694, 0.804, 1.0 ],
                    "varname": "Exponent_Slot_1[2]"
                }
            },
            {
                "box": {
                    "align": 1,
                    "applycolors": 1,
                    "bgcolor": [ 0.0, 0.0, 0.0, 1.0 ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [ 0.0, 0.0, 0.0, 1.0 ],
                    "bgfillcolor_color1": [ 0.08235294117647059, 0.08235294117647059, 0.08235294117647059, 1.0 ],
                    "bgfillcolor_color2": [ 0.208680531953877, 0.20868047419733, 0.208680489290039, 1.0 ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "color",
                    "elementcolor": [ 0.55, 0.55, 0.56, 1.0 ],
                    "fontsize": 14.0,
                    "id": "obj-200",
                    "items": [ "Gesture", "Cap" ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 77.27272653579712, 281.8181791305542, 192.75362479686737, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 166.90450447797775, 567.4157756567001, 81.97191989421844, 24.0 ],
                    "textcolor": [ 0.55, 0.55, 0.56, 1.0 ],
                    "textjustification": 1,
                    "truncate": 0
                }
            },
            {
                "box": {
                    "id": "obj-14",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 1147.7272617816925, 293.1818153858185, 22.0, 22.0 ],
                    "text": "t b"
                }
            },
            {
                "box": {
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 1131.8181710243225, 259.09090662002563, 34.0, 22.0 ],
                    "text": "sel 1"
                }
            },
            {
                "box": {
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 177.2727255821228, 615.9090850353241, 104.0, 22.0 ],
                    "text": "s Visu_RightHand"
                }
            },
            {
                "box": {
                    "id": "obj-59",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 77.27272653579712, 615.9090850353241, 96.0, 22.0 ],
                    "text": "s Visu_LeftHand"
                }
            },
            {
                "box": {
                    "id": "obj-58",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 177.2727255821228, 586.363630771637, 79.0, 22.0 ],
                    "text": "prepend right"
                }
            },
            {
                "box": {
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 77.27272653579712, 586.363630771637, 72.0, 22.0 ],
                    "text": "prepend left"
                }
            },
            {
                "box": {
                    "id": "obj-17",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 177.2727255821228, 545.4545402526855, 96.0, 22.0 ],
                    "text": "route /hand/right"
                }
            },
            {
                "box": {
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 77.27272653579712, 545.4545402526855, 89.0, 22.0 ],
                    "text": "route /hand/left"
                }
            },
            {
                "box": {
                    "id": "obj-18",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1213.6363520622253, 329.5454514026642, 68.0, 22.0 ],
                    "text": "camera_off"
                }
            },
            {
                "box": {
                    "id": "obj-22",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1131.8181710243225, 329.5454514026642, 69.0, 22.0 ],
                    "text": "camera_on"
                }
            },
            {
                "box": {
                    "id": "obj-31",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1061.363626241684, 329.5454514026642, 65.0, 22.0 ],
                    "text": "script stop"
                }
            },
            {
                "box": {
                    "id": "obj-19",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 990.9090814590454, 329.5454514026642, 66.0, 22.0 ],
                    "text": "script start"
                }
            },
            {
                "box": {
                    "id": "obj-34",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 902.272718667984, 606.8181760311127, 214.0, 22.0 ],
                    "saved_object_attributes": {
                        "autostart": 0,
                        "defer": 0,
                        "node_bin_path": "",
                        "npm_bin_path": "",
                        "watch": 0
                    },
                    "text": "node.script run_mediapipe_maxmsp.js",
                    "textfile": {
                        "filename": "run_mediapipe_maxmsp.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "obj-76",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 34.0, 95.0, 1444.0, 853.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1239.0, 924.0, 84.0, 26.0 ],
                                    "text": "Disabled",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 62.657111930847165, 236.20690894126892, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1270.0, 652.0, 32.0, 22.0 ],
                                    "text": "gate"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "" ],
                                    "patching_rect": [ 1397.0, 706.0, 34.0, 22.0 ],
                                    "text": "sel 0"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1446.0, 734.0, 84.0, 26.0 ],
                                    "text": "reset color",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1353.0, 617.0, 158.0, 26.0 ],
                                    "text": "On/Off Z axe (color)",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-1",
                                    "maxclass": "toggle",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1316.0, 618.0, 24.0, 24.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1051.0, 542.0, 72.0, 22.0 ],
                                    "text": "prepend set"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-2",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1051.0, 566.0, 47.0, 22.0 ],
                                    "text": "receive"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-7",
                                    "items": [ "R_wrist", ",", "R_thumb_cmc", ",", "R_thumb_mcp", ",", "R_thumb_ip", ",", "R_thumb_tip", ",", "R_index_mcp", ",", "R_index_pip", ",", "R_index_dip", ",", "R_index_tip", ",", "R_middle_mcp", ",", "R_middle_pip", ",", "R_middle_dip", ",", "R_middle_tip", ",", "R_ring_mcp", ",", "R_ring_pip", ",", "R_ring_dip", ",", "R_ring_tip", ",", "R_pinky_mcp", ",", "R_pinky_pip", ",", "R_pinky_dip", ",", "R_pinky_tip" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1051.0, 516.0, 137.3239454627037, 22.0 ],
                                    "varname": "Menu_R_Hand"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-6",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1208.0, 514.0, 158.0, 26.0 ],
                                    "text": "select landmark",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-5",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1397.0, 734.0, 29.5, 22.0 ],
                                    "text": "1"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-141",
                                    "linecount": 21,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 2082.19162940979, 93.1506781578064, 158.0, 294.0 ],
                                    "text": "0  wrist\n1  thumb_cmc\n2  thumb_mcp\n3  thumb_ip\n4  thumb_tip\n5  index_mcp\n6  index_pip\n7  index_dip\n8  index_tip\n9  middle_mcp\n10 middle_pip\n11 middle_dip\n12 middle_tip\n13 ring_mcp\n14 ring_pip\n15 ring_dip\n16 ring_tip\n17 pinky_mcp\n18 pinky_pip\n19 pinky_dip\n20 pinky_tip",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1140.0, 588.0, 158.0, 26.0 ],
                                    "text": "X, Y, Z (color)",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-317",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 672.3684146404266, 556.5789420604706, 79.0, 22.0 ],
                                    "text": "r R_pinky_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-318",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 672.3684146404266, 528.9473633766174, 82.0, 22.0 ],
                                    "text": "r R_pinky_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-319",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 672.3684146404266, 499.9999952316284, 82.0, 22.0 ],
                                    "text": "r R_pinky_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-320",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 672.3684146404266, 474.999995470047, 89.0, 22.0 ],
                                    "text": "r R_pinky_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-321",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 536.8421001434326, 556.5789420604706, 71.0, 22.0 ],
                                    "text": "r R_ring_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-322",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 536.8421001434326, 528.9473633766174, 74.0, 22.0 ],
                                    "text": "r R_ring_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-323",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 536.8421001434326, 499.9999952316284, 74.0, 22.0 ],
                                    "text": "r R_ring_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-324",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 536.8421001434326, 474.999995470047, 81.0, 22.0 ],
                                    "text": "r R_ring_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-325",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 401.3157856464386, 556.5789420604706, 86.0, 22.0 ],
                                    "text": "r R_middle_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-326",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 401.3157856464386, 528.9473633766174, 89.0, 22.0 ],
                                    "text": "r R_middle_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-327",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 401.3157856464386, 499.9999952316284, 89.0, 22.0 ],
                                    "text": "r R_middle_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-328",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 401.3157856464386, 474.999995470047, 96.0, 22.0 ],
                                    "text": "r R_middle_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-329",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 272.3684184551239, 556.5789420604706, 79.0, 22.0 ],
                                    "text": "r R_index_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-330",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 272.3684184551239, 528.9473633766174, 83.0, 22.0 ],
                                    "text": "r R_index_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-331",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 272.3684184551239, 499.9999952316284, 83.0, 22.0 ],
                                    "text": "r R_index_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-332",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 272.3684184551239, 474.999995470047, 89.0, 22.0 ],
                                    "text": "r R_index_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-333",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 144.73684072494507, 556.5789420604706, 84.0, 22.0 ],
                                    "text": "r R_thumb_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-334",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 144.73684072494507, 528.9473633766174, 81.0, 22.0 ],
                                    "text": "r R_thumb_ip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-335",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 144.73684072494507, 499.9999952316284, 94.0, 22.0 ],
                                    "text": "r R_thumb_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-336",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 144.73684072494507, 474.999995470047, 93.0, 22.0 ],
                                    "text": "r R_thumb_cmc"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-337",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 64.47368359565735, 474.999995470047, 56.0, 22.0 ],
                                    "text": "r R_wrist"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-314",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1153.0, 945.0, 69.0, 22.0 ],
                                    "text": "expr 1 - $f1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-312",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "float", "float", "float" ],
                                    "patching_rect": [ 1051.0, 590.0, 67.0, 22.0 ],
                                    "text": "unpack f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-287",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1270.0, 706.0, 73.0, 22.0 ],
                                    "text": "clip 0.06 0.3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-286",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 1270.0, 679.0, 31.0, 22.0 ],
                                    "text": "* -1."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-280",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1270.0, 734.0, 117.0, 22.0 ],
                                    "text": "scale 0.06 0.3 0.1 1."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-275",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1270.0, 762.0, 151.0, 22.0 ],
                                    "text": "color 0.882 0.588 0.008 $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-249",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1153.0, 912.0, 69.0, 22.0 ],
                                    "text": "expr 1 - $f1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-247",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1166.0, 735.0, 53.0, 22.0 ],
                                    "text": "clip 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-248",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1166.0, 762.0, 103.0, 22.0 ],
                                    "text": "scale 0. 1. 0. 127."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-246",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1051.0, 730.5882657766342, 53.0, 22.0 ],
                                    "text": "clip 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-245",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1051.0, 757.6470904350281, 103.0, 22.0 ],
                                    "text": "scale 0. 1. 0. 127."
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.882, 0.588, 0.008, 1.0 ],
                                    "id": "obj-244",
                                    "maxclass": "pictslider",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "int", "int" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1149.0, 801.0, 100.0, 100.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-309",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1352.0546962022781, 293.15066361427307, 48.31977593898773, 49.0 ],
                                    "text": "s R_pinky_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-308",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1290.4108650684357, 293.15066361427307, 48.45360553264618, 49.0 ],
                                    "text": "s R_pinky_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-307",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1224.657445192337, 293.15066361427307, 47.275792956352234, 49.0 ],
                                    "text": "s R_pinky_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-305",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1160.2738882303238, 293.15066361427307, 47.66728174686432, 49.0 ],
                                    "text": "s R_pinky_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-304",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1094.5204683542252, 293.15066361427307, 45.36082220077515, 49.0 ],
                                    "text": "s R_ring_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-303",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1032.8766372203827, 293.15066361427307, 47.654226541519165, 49.0 ],
                                    "text": "s R_ring_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-302",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 965.7533544301987, 293.15066361427307, 45.36082220077515, 49.0 ],
                                    "text": "s R_ring_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-301",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 904.1095232963562, 293.15066361427307, 46.37534856796265, 49.0 ],
                                    "text": "s R_ring_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-300",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 836.9862405061722, 293.15066361427307, 59.793811082839966, 49.0 ],
                                    "text": "s R_middle_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-299",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 775.3424093723297, 293.15066361427307, 59.0, 49.0 ],
                                    "text": "s R_middle_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-298",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 709.5889894962311, 293.15066361427307, 64.17311978340149, 49.0 ],
                                    "text": "s R_middle_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-297",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 645.2054325342178, 293.15066361427307, 62.73315989971161, 49.0 ],
                                    "text": "s R_middle_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-296",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 582.19173848629, 293.15066361427307, 55.481849670410156, 49.0 ],
                                    "text": "s R_index_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-295",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 517.8081815242767, 293.15066361427307, 62.96513420343399, 49.0 ],
                                    "text": "s R_index_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-294",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 454.7944874763489, 293.15066361427307, 53.0, 49.0 ],
                                    "text": "s R_index_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-293",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 390.41093051433563, 293.15066361427307, 56.70102775096893, 49.0 ],
                                    "text": "s R_index_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-292",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 327.3972364664078, 293.15066361427307, 59.793811082839966, 49.0 ],
                                    "text": "s R_thumb_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-291",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 261.64381659030914, 293.15066361427307, 57.15302240848541, 49.0 ],
                                    "text": "s R_thumb_ip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-290",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 198.6301225423813, 293.15066361427307, 60.91265118122101, 49.0 ],
                                    "text": "s R_thumb_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-289",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 130.13697683811188, 293.15066361427307, 61.855666637420654, 49.0 ],
                                    "text": "s R_thumb_cmc"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-288",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 62.657111930847165, 293.15066361427307, 58.0, 22.0 ],
                                    "text": "s R_wrist"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-221",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1354.794422030449, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-220",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1293.1505908966064, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-217",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1227.3971710205078, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-218",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1163.0136140584946, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-219",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1098.6300570964813, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-207",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1034.246500134468, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-208",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 971.2328060865402, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-209",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 904.1095232963562, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-210",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 839.725966334343, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-212",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 776.7122722864151, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-213",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 712.3287153244019, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-215",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 647.9451583623886, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-216",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 584.9314643144608, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-203",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 520.5479073524475, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-204",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 457.53421330451965, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-205",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 393.1506563425064, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-206",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 330.13696229457855, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-201",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 264.3835424184799, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-202",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 199.99998545646667, 241.09587287902832, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-171",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 130.17242062091827, 236.20690894126892, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-169",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 63,
                                    "outlettype": [ "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float" ],
                                    "patching_rect": [ 50.61728799343109, 134.17721474170685, 1365.0836445808409, 22.0 ],
                                    "text": "unpack f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-122",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 50.0, 90.0, 96.0, 22.0 ],
                                    "text": "route /hand/right"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-338",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 40.000002238540645, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-12", 0 ],
                                    "order": 1,
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "order": 0,
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-286", 0 ],
                                    "source": [ "obj-12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-169", 0 ],
                                    "source": [ "obj-122", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-15", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-171", 2 ],
                                    "source": [ "obj-169", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-171", 1 ],
                                    "source": [ "obj-169", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-171", 0 ],
                                    "source": [ "obj-169", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-201", 2 ],
                                    "source": [ "obj-169", 11 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-201", 1 ],
                                    "source": [ "obj-169", 10 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-201", 0 ],
                                    "source": [ "obj-169", 9 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-202", 2 ],
                                    "source": [ "obj-169", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-202", 1 ],
                                    "source": [ "obj-169", 7 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-202", 0 ],
                                    "source": [ "obj-169", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-203", 2 ],
                                    "source": [ "obj-169", 23 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-203", 1 ],
                                    "source": [ "obj-169", 22 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-203", 0 ],
                                    "source": [ "obj-169", 21 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-204", 2 ],
                                    "source": [ "obj-169", 20 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-204", 1 ],
                                    "source": [ "obj-169", 19 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-204", 0 ],
                                    "source": [ "obj-169", 18 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-205", 2 ],
                                    "source": [ "obj-169", 17 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-205", 1 ],
                                    "source": [ "obj-169", 16 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-205", 0 ],
                                    "source": [ "obj-169", 15 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-206", 2 ],
                                    "source": [ "obj-169", 14 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-206", 1 ],
                                    "source": [ "obj-169", 13 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-206", 0 ],
                                    "source": [ "obj-169", 12 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-207", 2 ],
                                    "source": [ "obj-169", 47 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-207", 1 ],
                                    "source": [ "obj-169", 46 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-207", 0 ],
                                    "source": [ "obj-169", 45 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-208", 2 ],
                                    "source": [ "obj-169", 44 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-208", 1 ],
                                    "source": [ "obj-169", 43 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-208", 0 ],
                                    "source": [ "obj-169", 42 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-209", 2 ],
                                    "source": [ "obj-169", 41 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-209", 1 ],
                                    "source": [ "obj-169", 40 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-209", 0 ],
                                    "source": [ "obj-169", 39 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 2 ],
                                    "source": [ "obj-169", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 1 ],
                                    "source": [ "obj-169", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "source": [ "obj-169", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-210", 2 ],
                                    "source": [ "obj-169", 38 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-210", 1 ],
                                    "source": [ "obj-169", 37 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-210", 0 ],
                                    "source": [ "obj-169", 36 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-212", 2 ],
                                    "source": [ "obj-169", 35 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-212", 1 ],
                                    "source": [ "obj-169", 34 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-212", 0 ],
                                    "source": [ "obj-169", 33 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-213", 2 ],
                                    "source": [ "obj-169", 32 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-213", 1 ],
                                    "source": [ "obj-169", 31 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-213", 0 ],
                                    "source": [ "obj-169", 30 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-215", 2 ],
                                    "source": [ "obj-169", 29 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-215", 1 ],
                                    "source": [ "obj-169", 28 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-215", 0 ],
                                    "source": [ "obj-169", 27 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-216", 2 ],
                                    "source": [ "obj-169", 26 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-216", 1 ],
                                    "source": [ "obj-169", 25 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-216", 0 ],
                                    "source": [ "obj-169", 24 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-217", 2 ],
                                    "source": [ "obj-169", 56 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-217", 1 ],
                                    "source": [ "obj-169", 55 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-217", 0 ],
                                    "source": [ "obj-169", 54 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-218", 2 ],
                                    "source": [ "obj-169", 53 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-218", 1 ],
                                    "source": [ "obj-169", 52 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-218", 0 ],
                                    "source": [ "obj-169", 51 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-219", 2 ],
                                    "source": [ "obj-169", 50 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-219", 1 ],
                                    "source": [ "obj-169", 49 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-219", 0 ],
                                    "source": [ "obj-169", 48 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-220", 2 ],
                                    "source": [ "obj-169", 59 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-220", 1 ],
                                    "source": [ "obj-169", 58 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-220", 0 ],
                                    "source": [ "obj-169", 57 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-221", 2 ],
                                    "source": [ "obj-169", 62 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-221", 1 ],
                                    "source": [ "obj-169", 61 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-221", 0 ],
                                    "source": [ "obj-169", 60 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-289", 0 ],
                                    "source": [ "obj-171", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-312", 0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-291", 0 ],
                                    "source": [ "obj-201", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-290", 0 ],
                                    "source": [ "obj-202", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-295", 0 ],
                                    "source": [ "obj-203", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-294", 0 ],
                                    "source": [ "obj-204", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-293", 0 ],
                                    "source": [ "obj-205", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-292", 0 ],
                                    "source": [ "obj-206", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-303", 0 ],
                                    "source": [ "obj-207", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-302", 0 ],
                                    "source": [ "obj-208", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-301", 0 ],
                                    "source": [ "obj-209", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-288", 0 ],
                                    "source": [ "obj-21", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-300", 0 ],
                                    "source": [ "obj-210", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-299", 0 ],
                                    "source": [ "obj-212", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-298", 0 ],
                                    "source": [ "obj-213", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-297", 0 ],
                                    "source": [ "obj-215", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-296", 0 ],
                                    "source": [ "obj-216", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-307", 0 ],
                                    "source": [ "obj-217", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-305", 0 ],
                                    "source": [ "obj-218", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-304", 0 ],
                                    "source": [ "obj-219", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-308", 0 ],
                                    "source": [ "obj-220", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-309", 0 ],
                                    "source": [ "obj-221", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-244", 0 ],
                                    "source": [ "obj-245", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-245", 0 ],
                                    "source": [ "obj-246", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-248", 0 ],
                                    "source": [ "obj-247", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-244", 1 ],
                                    "source": [ "obj-248", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-244", 0 ],
                                    "source": [ "obj-275", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-275", 0 ],
                                    "source": [ "obj-280", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-287", 0 ],
                                    "source": [ "obj-286", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-280", 0 ],
                                    "source": [ "obj-287", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-2", 0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-12", 1 ],
                                    "midpoints": [ 1108.5, 624.8359308242798, 1292.5, 624.8359308242798 ],
                                    "source": [ "obj-312", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-246", 0 ],
                                    "source": [ "obj-312", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-247", 0 ],
                                    "midpoints": [ 1084.5, 631.6515084593557, 1175.5, 631.6515084593557 ],
                                    "source": [ "obj-312", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-122", 0 ],
                                    "source": [ "obj-338", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-275", 0 ],
                                    "source": [ "obj-5", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-7", 1 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 368.18181467056274, 545.4545402526855, 75.0, 22.0 ],
                    "text": "p RightHand"
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 34.0, 95.0, 1444.0, 853.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1479.0, 840.0, 158.0, 26.0 ],
                                    "text": "Disabled",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "" ],
                                    "patching_rect": [ 1404.0, 686.0, 34.0, 22.0 ],
                                    "text": "sel 0"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1446.0, 715.0, 84.0, 26.0 ],
                                    "text": "reset color",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1353.0, 605.0, 158.0, 26.0 ],
                                    "text": "On/Off Z axe (color)",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-9",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1404.0, 717.0, 29.5, 22.0 ],
                                    "text": "1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-6",
                                    "maxclass": "toggle",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1312.0, 606.0, 24.0, 24.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-2",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1278.0, 638.0, 32.0, 22.0 ],
                                    "text": "gate"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1065.0, 529.0, 72.0, 22.0 ],
                                    "text": "prepend set"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1207.0, 501.0, 158.0, 26.0 ],
                                    "text": "select landmark",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-8",
                                    "items": [ "L_wrist", ",", "L_thumb_cmc", ",", "L_thumb_mcp", ",", "L_thumb_ip", ",", "L_thumb_tip", ",", "L_index_mcp", ",", "L_index_pip", ",", "L_index_dip", ",", "L_index_tip", ",", "L_middle_mcp", ",", "L_middle_pip", ",", "L_middle_dip", ",", "L_middle_tip", ",", "L_ring_mcp", ",", "L_ring_pip", ",", "L_ring_dip", ",", "L_ring_tip", ",", "L_pinky_mcp", ",", "L_pinky_pip", ",", "L_pinky_dip", ",", "L_pinky_tip" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1066.0, 503.0, 137.3239454627037, 22.0 ],
                                    "varname": "Menu_L_Hand"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-141",
                                    "linecount": 21,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1421.0526180267334, 73.6842098236084, 158.0, 294.0 ],
                                    "text": "0  wrist\n1  thumb_cmc\n2  thumb_mcp\n3  thumb_ip\n4  thumb_tip\n5  index_mcp\n6  index_pip\n7  index_dip\n8  index_tip\n9  middle_mcp\n10 middle_pip\n11 middle_dip\n12 middle_tip\n13 ring_mcp\n14 ring_pip\n15 ring_dip\n16 ring_tip\n17 pinky_mcp\n18 pinky_pip\n19 pinky_dip\n20 pinky_tip",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1065.0, 553.0, 47.0, 22.0 ],
                                    "text": "receive"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                                    "bubbletextmargin": 6,
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1141.0, 577.0, 158.0, 26.0 ],
                                    "text": "X, Y, Z (color)",
                                    "textcolor": [ 0.290283203125, 0.290283203125, 0.290283203125, 1.0 ],
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-317",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 658.0, 358.0, 77.0, 22.0 ],
                                    "text": "r L_pinky_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-318",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 658.0, 330.0, 80.0, 22.0 ],
                                    "text": "r L_pinky_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-319",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 658.0, 301.0, 80.0, 22.0 ],
                                    "text": "r L_pinky_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-320",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 658.0, 276.0, 87.0, 22.0 ],
                                    "text": "r L_pinky_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-321",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 522.0, 358.0, 69.0, 22.0 ],
                                    "text": "r L_ring_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-322",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 522.0, 330.0, 72.0, 22.0 ],
                                    "text": "r L_ring_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-323",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 522.0, 301.0, 72.0, 22.0 ],
                                    "text": "r L_ring_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-324",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 522.0, 276.0, 79.0, 22.0 ],
                                    "text": "r L_ring_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-325",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 387.0, 358.0, 84.0, 22.0 ],
                                    "text": "r L_middle_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-326",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 387.0, 330.0, 87.0, 22.0 ],
                                    "text": "r L_middle_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-327",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 387.0, 301.0, 87.0, 22.0 ],
                                    "text": "r L_middle_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-328",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 387.0, 276.0, 94.0, 22.0 ],
                                    "text": "r L_middle_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-329",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 258.0, 358.0, 77.0, 22.0 ],
                                    "text": "r L_index_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-330",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 258.0, 330.0, 81.0, 22.0 ],
                                    "text": "r L_index_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-331",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 258.0, 301.0, 81.0, 22.0 ],
                                    "text": "r L_index_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-332",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 258.0, 276.0, 87.0, 22.0 ],
                                    "text": "r L_index_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-333",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 130.0, 358.0, 82.0, 22.0 ],
                                    "text": "r L_thumb_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-334",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 130.0, 330.0, 79.0, 22.0 ],
                                    "text": "r L_thumb_ip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-335",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 130.0, 301.0, 92.0, 22.0 ],
                                    "text": "r L_thumb_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-336",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 130.0, 276.0, 91.0, 22.0 ],
                                    "text": "r L_thumb_cmc"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-337",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 276.0, 54.0, 22.0 ],
                                    "text": "r L_wrist"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-314",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1403.0, 856.0, 69.0, 22.0 ],
                                    "text": "expr 1 - $f1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-312",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "float", "float", "float" ],
                                    "patching_rect": [ 1065.0, 577.0, 67.0, 22.0 ],
                                    "text": "unpack f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-287",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1278.0, 692.0, 73.0, 22.0 ],
                                    "text": "clip 0.06 0.3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-286",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 1278.0, 667.0, 31.0, 22.0 ],
                                    "text": "* -1."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-280",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1278.0, 719.0, 117.0, 22.0 ],
                                    "text": "scale 0.06 0.3 0.1 1."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-275",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1278.0, 747.0, 151.0, 22.0 ],
                                    "text": "color 0.882 0.588 0.008 $1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-249",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1403.0, 826.0, 69.0, 22.0 ],
                                    "text": "expr 1 - $f1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-247",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1174.0, 721.0, 53.0, 22.0 ],
                                    "text": "clip 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-248",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1174.0, 747.0, 103.0, 22.0 ],
                                    "text": "scale 0. 1. 0. 127."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-246",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1064.0, 717.0, 53.0, 22.0 ],
                                    "text": "clip 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-245",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1064.0, 743.0, 103.0, 22.0 ],
                                    "text": "scale 0. 1. 0. 127."
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.882, 0.588, 0.008, 1.0 ],
                                    "id": "obj-244",
                                    "maxclass": "pictslider",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "int", "int" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1157.0, 787.0, 100.0, 100.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-309",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1331.0, 189.8734165430069, 49.27846419811249, 49.0 ],
                                    "text": "s L_pinky_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-308",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1270.5, 189.8734165430069, 47.753148555755615, 49.0 ],
                                    "text": "s L_pinky_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-307",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1202.0, 189.8734165430069, 50.43036460876465, 49.0 ],
                                    "text": "s L_pinky_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-305",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1140.0, 189.8734165430069, 48.0, 49.0 ],
                                    "text": "s L_pinky_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-304",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1074.0, 189.8734165430069, 47.5, 49.0 ],
                                    "text": "s L_ring_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-303",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1012.0, 189.8734165430069, 48.02530384063721, 49.0 ],
                                    "text": "s L_ring_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-302",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 946.0, 189.8734165430069, 46.5, 49.0 ],
                                    "text": "s L_ring_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-301",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 884.0, 189.8734165430069, 46.911381483078, 49.0 ],
                                    "text": "s L_ring_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-300",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 818.5, 189.8734165430069, 58.0, 49.0 ],
                                    "text": "s L_middle_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-299",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 756.5, 189.8734165430069, 57.5, 49.0 ],
                                    "text": "s L_middle_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-298",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 690.5, 189.8734165430069, 59.39473056793213, 49.0 ],
                                    "text": "s L_middle_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-297",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 626.0, 189.8734165430069, 58.0, 49.0 ],
                                    "text": "s L_middle_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-296",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 562.5, 189.8734165430069, 53.86841607093811, 49.0 ],
                                    "text": "s L_index_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-295",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 498.0, 189.8734165430069, 53.0, 49.0 ],
                                    "text": "s L_index_dip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-294",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 435.0, 189.8734165430069, 54.84210157394409, 49.0 ],
                                    "text": "s L_index_pip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-293",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 370.5, 189.8734165430069, 56.5, 49.0 ],
                                    "text": "s L_index_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-292",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 307.0, 189.8734165430069, 57.0, 49.0 ],
                                    "text": "s L_thumb_tip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-291",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 242.5, 189.8734165430069, 57.0, 49.0 ],
                                    "text": "s L_thumb_ip"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-290",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 178.0, 189.8734165430069, 55.0, 49.0 ],
                                    "text": "s L_thumb_mcp"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-289",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 114.5569611787796, 189.8734165430069, 56.0, 49.0 ],
                                    "text": "s L_thumb_cmc"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-288",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 52.99999952316284, 189.8734165430069, 48.0, 35.0 ],
                                    "text": "s L_wrist"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-221",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1332.2784641981125, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-220",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1270.2531485557556, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-217",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1204.4303646087646, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-218",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1139.873403429985, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-219",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1076.5822650194168, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-207",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1012.0253038406372, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-208",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 948.734165430069, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-209",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 882.911381483078, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-210",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 818.3544203042984, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-212",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 755.0632818937302, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-213",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 690.5063207149506, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-215",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 625.949359536171, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-216",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 562.6582211256027, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-203",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 498.1012599468231, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-204",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 434.8101215362549, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-205",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 370.5, 165.8734165430069, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-206",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 306.96202194690704, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-201",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 242.40506076812744, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-202",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 177.84809958934784, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-171",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 114.5569611787796, 162.02531564235687, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-170",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 52.99999952316284, 162.8734165430069, 48.0, 22.0 ],
                                    "text": "pak f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-169",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 63,
                                    "outlettype": [ "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float", "float" ],
                                    "patching_rect": [ 50.0, 134.17721474170685, 1343.058935865027, 22.0 ],
                                    "text": "unpack f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f f"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-122",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 50.0, 100.0, 89.0, 22.0 ],
                                    "text": "route /hand/left"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-338",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 40.000002238540645, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-312", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-169", 0 ],
                                    "source": [ "obj-122", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-9", 0 ],
                                    "source": [ "obj-15", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-170", 2 ],
                                    "source": [ "obj-169", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-170", 1 ],
                                    "source": [ "obj-169", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-170", 0 ],
                                    "source": [ "obj-169", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-171", 2 ],
                                    "source": [ "obj-169", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-171", 1 ],
                                    "source": [ "obj-169", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-171", 0 ],
                                    "source": [ "obj-169", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-201", 2 ],
                                    "source": [ "obj-169", 11 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-201", 1 ],
                                    "source": [ "obj-169", 10 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-201", 0 ],
                                    "source": [ "obj-169", 9 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-202", 2 ],
                                    "source": [ "obj-169", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-202", 1 ],
                                    "source": [ "obj-169", 7 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-202", 0 ],
                                    "source": [ "obj-169", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-203", 2 ],
                                    "source": [ "obj-169", 23 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-203", 1 ],
                                    "source": [ "obj-169", 22 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-203", 0 ],
                                    "source": [ "obj-169", 21 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-204", 2 ],
                                    "source": [ "obj-169", 20 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-204", 1 ],
                                    "source": [ "obj-169", 19 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-204", 0 ],
                                    "source": [ "obj-169", 18 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-205", 2 ],
                                    "source": [ "obj-169", 17 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-205", 1 ],
                                    "source": [ "obj-169", 16 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-205", 0 ],
                                    "source": [ "obj-169", 15 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-206", 2 ],
                                    "source": [ "obj-169", 14 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-206", 1 ],
                                    "source": [ "obj-169", 13 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-206", 0 ],
                                    "source": [ "obj-169", 12 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-207", 2 ],
                                    "source": [ "obj-169", 47 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-207", 1 ],
                                    "source": [ "obj-169", 46 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-207", 0 ],
                                    "source": [ "obj-169", 45 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-208", 2 ],
                                    "source": [ "obj-169", 44 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-208", 1 ],
                                    "source": [ "obj-169", 43 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-208", 0 ],
                                    "source": [ "obj-169", 42 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-209", 2 ],
                                    "source": [ "obj-169", 41 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-209", 1 ],
                                    "source": [ "obj-169", 40 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-209", 0 ],
                                    "source": [ "obj-169", 39 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-210", 2 ],
                                    "source": [ "obj-169", 38 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-210", 1 ],
                                    "source": [ "obj-169", 37 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-210", 0 ],
                                    "source": [ "obj-169", 36 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-212", 2 ],
                                    "source": [ "obj-169", 35 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-212", 1 ],
                                    "source": [ "obj-169", 34 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-212", 0 ],
                                    "source": [ "obj-169", 33 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-213", 2 ],
                                    "source": [ "obj-169", 32 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-213", 1 ],
                                    "source": [ "obj-169", 31 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-213", 0 ],
                                    "source": [ "obj-169", 30 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-215", 2 ],
                                    "source": [ "obj-169", 29 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-215", 1 ],
                                    "source": [ "obj-169", 28 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-215", 0 ],
                                    "source": [ "obj-169", 27 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-216", 2 ],
                                    "source": [ "obj-169", 26 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-216", 1 ],
                                    "source": [ "obj-169", 25 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-216", 0 ],
                                    "source": [ "obj-169", 24 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-217", 2 ],
                                    "source": [ "obj-169", 56 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-217", 1 ],
                                    "source": [ "obj-169", 55 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-217", 0 ],
                                    "source": [ "obj-169", 54 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-218", 2 ],
                                    "source": [ "obj-169", 53 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-218", 1 ],
                                    "source": [ "obj-169", 52 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-218", 0 ],
                                    "source": [ "obj-169", 51 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-219", 2 ],
                                    "source": [ "obj-169", 50 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-219", 1 ],
                                    "source": [ "obj-169", 49 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-219", 0 ],
                                    "source": [ "obj-169", 48 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-220", 2 ],
                                    "source": [ "obj-169", 59 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-220", 1 ],
                                    "source": [ "obj-169", 58 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-220", 0 ],
                                    "source": [ "obj-169", 57 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-221", 2 ],
                                    "source": [ "obj-169", 62 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-221", 1 ],
                                    "source": [ "obj-169", 61 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-221", 0 ],
                                    "source": [ "obj-169", 60 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-288", 0 ],
                                    "source": [ "obj-170", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-289", 0 ],
                                    "source": [ "obj-171", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-286", 0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-291", 0 ],
                                    "source": [ "obj-201", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-290", 0 ],
                                    "source": [ "obj-202", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-295", 0 ],
                                    "source": [ "obj-203", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-294", 0 ],
                                    "source": [ "obj-204", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-293", 0 ],
                                    "source": [ "obj-205", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-292", 0 ],
                                    "source": [ "obj-206", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-303", 0 ],
                                    "source": [ "obj-207", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-302", 0 ],
                                    "source": [ "obj-208", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-301", 0 ],
                                    "source": [ "obj-209", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-300", 0 ],
                                    "source": [ "obj-210", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-299", 0 ],
                                    "source": [ "obj-212", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-298", 0 ],
                                    "source": [ "obj-213", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-297", 0 ],
                                    "source": [ "obj-215", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-296", 0 ],
                                    "source": [ "obj-216", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-307", 0 ],
                                    "source": [ "obj-217", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-305", 0 ],
                                    "source": [ "obj-218", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-304", 0 ],
                                    "source": [ "obj-219", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-308", 0 ],
                                    "source": [ "obj-220", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-309", 0 ],
                                    "source": [ "obj-221", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-244", 0 ],
                                    "source": [ "obj-245", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-245", 0 ],
                                    "source": [ "obj-246", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-248", 0 ],
                                    "source": [ "obj-247", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-244", 1 ],
                                    "source": [ "obj-248", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-244", 0 ],
                                    "source": [ "obj-275", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-275", 0 ],
                                    "source": [ "obj-280", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-287", 0 ],
                                    "source": [ "obj-286", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-280", 0 ],
                                    "source": [ "obj-287", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-1", 0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-2", 1 ],
                                    "midpoints": [ 1122.5, 608.248796521686, 1300.5, 608.248796521686 ],
                                    "source": [ "obj-312", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-246", 0 ],
                                    "source": [ "obj-312", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-247", 0 ],
                                    "midpoints": [ 1098.5, 617.2890575020574, 1183.5, 617.2890575020574 ],
                                    "source": [ "obj-312", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-122", 0 ],
                                    "source": [ "obj-338", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "order": 0,
                                    "source": [ "obj-6", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-2", 0 ],
                                    "order": 1,
                                    "source": [ "obj-6", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-8", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-275", 0 ],
                                    "source": [ "obj-9", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 288.63636088371277, 545.4545402526855, 67.0, 22.0 ],
                    "text": "p LeftHand"
                }
            },
            {
                "box": {
                    "bubble": 1,
                    "bubble_bgcolor": [ 0.87841796875, 0.8784179091453552, 0.87841796875, 0.57 ],
                    "bubble_outlinecolor": [ 0.05098036676645279, 0.05098036676645279, 0.05098036676645279, 1.0 ],
                    "bubbleside": 2,
                    "bubbletextmargin": 6,
                    "fontsize": 30.0,
                    "id": "obj-69",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 77.27272653579712, 156.8181803226471, 253.52113008499146, 61.0 ],
                    "text": "INPUTS",
                    "textcolor": [ 0.0, 0.0, 0.0, 1.0 ],
                    "textjustification": 1
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "color": [ 1.0, 0.4117647059, 0.01568627451, 1.0 ],
                    "destination": [ "obj-200", 0 ],
                    "order": 1,
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 1.0, 0.4117647059, 0.01568627451, 1.0 ],
                    "destination": [ "obj-9", 0 ],
                    "midpoints": [ 86.77272653579712, 274.9018361722119, 911.772718667984, 274.9018361722119 ],
                    "order": 0,
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 0 ],
                    "source": [ "obj-10", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-189", 0 ],
                    "source": [ "obj-128", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-237", 0 ],
                    "source": [ "obj-128", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-24", 0 ],
                    "order": 1,
                    "source": [ "obj-13", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "order": 2,
                    "source": [ "obj-13", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-65", 0 ],
                    "order": 0,
                    "source": [ "obj-13", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 0 ],
                    "source": [ "obj-14", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-59", 0 ],
                    "source": [ "obj-16", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-58", 0 ],
                    "source": [ "obj-17", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 1 ],
                    "source": [ "obj-18", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-187", 0 ],
                    "source": [ "obj-189", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 1 ],
                    "source": [ "obj-19", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-205", 0 ],
                    "source": [ "obj-199", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 1.0, 0.4117647059, 0.01568627451, 1.0 ],
                    "destination": [ "obj-19", 0 ],
                    "midpoints": [ 423.1363596916199, 269.2912417650223, 1000.4090814590454, 269.2912417650223 ],
                    "order": 0,
                    "source": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 1.0, 0.4117647059, 0.01568627451, 1.0 ],
                    "destination": [ "obj-243", 0 ],
                    "order": 1,
                    "source": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-201", 0 ],
                    "source": [ "obj-200", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-202", 0 ],
                    "source": [ "obj-201", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-199", 0 ],
                    "source": [ "obj-202", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-11", 0 ],
                    "order": 1,
                    "source": [ "obj-204", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-17", 0 ],
                    "order": 2,
                    "source": [ "obj-204", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-76", 0 ],
                    "order": 0,
                    "source": [ "obj-204", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-8", 0 ],
                    "order": 3,
                    "source": [ "obj-204", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-204", 0 ],
                    "source": [ "obj-205", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 1 ],
                    "source": [ "obj-22", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "source": [ "obj-23", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "source": [ "obj-23", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-233", 0 ],
                    "source": [ "obj-237", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-29", 0 ],
                    "source": [ "obj-24", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-253", 0 ],
                    "midpoints": [ 423.1363596916199, 322.5193977355957, 423.1363596916199, 322.5193977355957 ],
                    "source": [ "obj-243", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-128", 0 ],
                    "source": [ "obj-253", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-23", 0 ],
                    "source": [ "obj-29", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.9911933541297913, 0.3534833788871765, 0.33381739258766174, 1.0 ],
                    "destination": [ "obj-18", 0 ],
                    "order": 0,
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "color": [ 0.9911933541297913, 0.3534833788871765, 0.33381739258766174, 1.0 ],
                    "destination": [ "obj-31", 0 ],
                    "order": 1,
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 1 ],
                    "source": [ "obj-31", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-14", 0 ],
                    "source": [ "obj-4", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 0 ],
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 0 ],
                    "source": [ "obj-58", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-152", 0 ],
                    "source": [ "obj-6", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-34", 0 ],
                    "source": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "source": [ "obj-60", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "source": [ "obj-63", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-63", 0 ],
                    "source": [ "obj-65", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "source": [ "obj-7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-16", 0 ],
                    "source": [ "obj-8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-10", 0 ],
                    "source": [ "obj-9", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-199": [ "live.numbox[91]", "live.numbox[37]", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0
    }
}