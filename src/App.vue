<template>
  <!-- TODO: fork me on github -->
  <div id="app">
    <div id="countdown_container">
      <h2 id="countdown_title">Countdown to<br/>50 Million XRP Ledgers!</h2>
      <div id="subcountdown_container">
        <div class='subcountdown'>
          <div class='subcountdown_counter'>{{countdown_days}}</div>
          <div class='subcountdown_label'>
            Days
          </div>
        </div>

        <div class='subcountdown'>
          <div class='subcountdown_counter'>{{countdown_hours}}</div>
          <div class='subcountdown_label'>
            Hours
          </div>
        </div>

        <div class='subcountdown'>
          <div class='subcountdown_counter'>{{countdown_mins}}</div>
          <div class='subcountdown_label'>
            Minutes
          </div>
        </div>

        <div class='subcountdown'>
          <div class='subcountdown_counter'>{{countdown_secs}}</div>
          <div class='subcountdown_label'>
            Seconds
          </div>
        </div>
      </div>

      <div id="ledger_status_container">
        <span id="current_ledger">Current Ledger: {{current_ledger | delim}}</span><br/>
        <span id="remaining_ledgers">Remaining: {{remaining_ledgers | delim}}</span>
      </div>
    </div>

    <div id="contest_entry">
      <div>To celebrate 50 Million, we're giving away 50 XRP to 50 lucky winners!</div>
      <div>To enter this contest simply fill out this form with a valid email and valid (already activated) XRP ledger address!</div>
    </div>

    <div id="contributors">
      <div class="contributor_container">
        <div class='contributor_label'>Platinum Sponsors:</div>
        <p>Expect new features from these Developers & Projects at/around 50 Million</p>
        <ul>
          <li>Dev Null Productions</li>
          <li>Rabbit Kick Club</li>
          <li>XRP Scan</li>
          <li>BitHomp</li>
          <li>XRPTipBot-Stats</li>
          <li>XRP Toolkit</li>
        </ul>
      </div>

      <div class="contributor_container">
        <div class='contributor_label'>Gold Level Contributors:</div>
        <p>Many thanks to these awesome supporters:</p>
        <ul>
          <li>Wietse Wind</li>
          <li>XRPL Labs</li>
          <li>Thomas Silkj.</li>
          <li>...</li>
        </ul>
      </div>

      <div class="contributor_container">
        <div class='contributor_label'>Community Level Supporters:</div>
        <p>& the many more (too many to list here!)</p>
        <ul>
        <li>...</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
const TARGET = 50000000;

export default {
  name: 'app',
  components: {
  },

  data(){
    return {current_ledger : 0};
  },

  computed : {
    countdown_days : function(){
      return 0;
    },

    countdown_hours : function(){
      return 0;
    },

    countdown_mins : function(){
      return 0;
    },

    countdown_secs : function(){
      return 0;
    },

    remaining_ledgers : function(){
      return TARGET - this.current_ledger;
    }
  },

  created : function(){
    this.$options.sockets.onmessage = function(m){
      var ledger = JSON.parse(m.data)["ledger_index"];
      if(!ledger) return;
      this.current_ledger = ledger;
    }.bind(this);

    this.$options.sockets.onopen = function(){
      this.$socket.sendObj({command : 'subscribe', streams : ['ledger']})
    }.bind(this);

    // get rate stats...
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css?family=Lobster+Two');
@import url('https://fonts.googleapis.com/css?family=Roboto');

html, body{
  height: 100%;
  padding: 0;
  margin: 0;
}

#app {
  height: 100%;
  text-align: center;
  display: flex;
  flex-direction: column;
}

#countdown_container{
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;

  background-image: url('./assets/party.png');
  background-size: 100% 100%;
  color: white;
  padding: 25px;
  min-height: 450px;
}

#countdown_title{
  border-radius: 3px;
  background-color: rgba(48, 47, 47, 0.5);
  font-family: Lobster Two,cursive;
  font-size: 70px;
}

#subcountdown_container{
  display: flex;
  justify-content: center;
}

.subcountdown{
  margin: 5px;
  min-width: 125px;
}

.subcountdown_counter{
  padding: 5px;
  font-size: 3em;
  background: rgba(40,50,61,.62);
  font-family: Roboto,sans-serif;
}

.subcountdown_label{
  margin-top: 3px;
  padding: 5px;
  font-size: 1.4em;
  background: rgba(40,50,61,.62);
  font-family: Helvetica,Arial,Sans-Serif;
}

#ledger_status_container{
  font-family: Lobster Two;
  font-size: 30px;
  color: blue;
  font-weight: bold;
}

#contest_entry{
  background-color: red;
  min-height: 250px;
  flex-grow: 1;
}

#contributors{
  background: blue;
  display: flex;
  justify-content: space-evenly;
}

.contributor_container{
  background: green;
  text-align: center;
  padding: 15px;
  width: 25%;
}
</style>
