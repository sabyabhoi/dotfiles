webcam = {
  matches = {
    {
      { "node.name", "equals", "v4l2_input.pci-0000_05_00.3-usb-0_4_1.0" },
    },
  },
  apply_properties = {
    ["node.name"] = "Webcam",
    ["node.nick"] = "Webcam",
    ["node.description"] = "Laptop webcam source",
  },
}

table.insert(v4l2_monitor.rules,webcam)
