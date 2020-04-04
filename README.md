

**MawiTestJob** is a test assignment.

## Installation

Use the consol.

```bash
pod install
```

## Test assignment info

First screen. Consists of the list of recorded data and the button “Start new measurement”.

● Each item in the list is measurement data. Fields: id, date, list of Integer points. By clicking on one of the list items, there should be a transition to the chart viewing screen.

● The button "Start new measurement" should show the measurement mode selector: endless or 5 minutes. Mode selection must lead to the second screen.

Second screen. Consists of the real-time line chart and “Stop” button and TextField that shows text “Valid” or "Invalid”.

After starting this screen, the generator should start, which will generate numbered packets every 250 ms for 120 values [-2048..2048]. You must subscribe to updates of this generator to display data-packets on a real-time chart.

Also, you must scan the incoming data with a window of 1000 values with a step of 250 values and at each step give the result: “valid” or “not valid” (can be in random order). If 5 times in a row was not valid then complete the measurement.

Measurement should take place in two modes:

● fixed time – 5 minutes;

● endless.

After the measurement is completed or stopped, the data must be saved in the local database. When minimizing the application (pressing the "Home" button, etc.), data should continue to stream.

Unit and integration tests is required.

Required tech stack:

● RxSwift

● Realm database

● https://github.com/danielgindi/Charts

Required architecture: MVVM


## License
[MIT](https://choosealicense.com/licenses/mit/)
