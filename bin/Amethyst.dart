import 'package:toml/toml.dart';
import 'package:irc/client.dart';
import 'moon.dart' as moon;
import "roller.dart" as roll;

void main() async {
  var document = await TomlDocument.load('config.toml');
  var cfg = document.toMap();

  var irccfg = Configuration(
      host: cfg['IRC']['Server'],
      port: cfg['IRC']['Port'],
      nickname: cfg['IRC']['NickName'],
      username: cfg['IRC']['RealName']);

  var client = Client(irccfg);

  client.onReady.listen((event) {
    event.join(cfg['IRC']['ChannelDice']);
    event.join(cfg['IRC']['ChannelOOC']);
  });

  client.onMessage.listen((event) async {
    // Log any message events to the console
    print('<${event.target.name}><${event.from.name}> ${event.message}');
    var msg = event.message.split(' ');
    switch (msg[0]) {
      case '!hello':
        event.reply('hi');
        break;
      case '!moon':
        var moonStr =
            await moon.moonCommand(DateTime.now().millisecondsSinceEpoch);
        event.reply(moonStr);
        break;
      case '!owod':
        var rolldie =
            await roll.oWoD(msg[1], msg[2], event.from.name.toString());
        event.reply(rolldie);
    }
  });

  client.connect();
}
