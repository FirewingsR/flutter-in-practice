import 'package:flutter/material.dart';

import '../../container.dart';

class BootstrapPage extends StatelessWidget {

  final bool needLogout;

  BootstrapPage({
    this.needLogout = false
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _Body(needLogout: needLogout),);
  }
}

class _Body extends StatefulWidget {
  final bool needLogout;
  _Body({
    this.needLogout = false
  });

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();

    _bootstrap();
  }

  void _bootstrap() async {
    WgContainer().basePresenter.doWithLoading(
        () async {
          if (widget.needLogout) {
            // todo
            print('logout');
          }

          final user = null;

          WgContainer().basePresenter.navigator().pushNamedAndRemoveUntil(
              user == null ? '/login' : '/tab', (route) => false);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: <Widget>[
          Spacer(flex: 5),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: Image(
              image: AssetImage('assets/weiguan/weiguan.png'),
            ),
          ),
          Spacer(),
          Text(
            'loading...',
            style: Theme.of(context)
              .textTheme
              .body1
              .copyWith(color: Theme.of(context).hintColor),
          ),
          Spacer(flex: 5,)
        ],
      ),
    );
  }
}

