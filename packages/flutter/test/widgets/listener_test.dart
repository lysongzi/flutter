// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

void main() {
  testWidgets('Events bubble up the tree', (WidgetTester tester) async {
    final List<String> log = new List<String>();

    await tester.pumpWidget(
      new Listener(
        onPointerDown: (_) {
          log.add('top');
        },
        child: new Listener(
          onPointerDown: (_) {
            log.add('middle');
          },
          child: new DecoratedBox(
            decoration: const BoxDecoration(),
            child: new Listener(
              onPointerDown: (_) {
                log.add('bottom');
              },
              child: new Text('X')
            )
          )
        )
      )
    );

    await tester.tap(find.text('X'));

    expect(log, equals(<String>[
      'bottom',
      'middle',
      'top',
    ]));
  });
}
