<template>
  <!-- TODO: fork me on github -->
  <div id="app" :class="$mq">
    <div id="countdown_container">
      <div v-if="!countdown_reached">
        <h2 id="countdown_title">Countdown to<br/>50 Million XRP Ledgers!</h2>
        <h4 id="countdown_subtitle">A XRP Community Celebration</h4>
      </div>

      <div v-else class="pyro">
        <div class="before"></div>
        <div class="after"></div>

        <h1 id="countdown_title" class="blinking" style="padding: 50px;">50 Million Ledgers!!!!!!!</h1>
      </div>

      <div class="text-center" v-if="!have_current_ledger">
        <b-spinner />
      </div>

      <div id="subcountdown_container" v-if="have_current_ledger">
        <div class='subcountdown_subcontainer'>
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
        </div>

        <div class='subcountdown_subcontainer'>
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
      </div>

      <div id="how_computed" v-b-modal.how_computed_modal>
        How is this computed?
      </div>

      <b-modal id="how_computed_modal" title="How is this computed?" ok-only>
        <p class="my-4">
        While the XRP Ledger implements <b>Deterministic Consensus Validation</b>,
        the actual duration is negotiated on a ledger-by-ledger basis.
        Ledger validation cycles can vary in length and typically run from <b>2 to 4 seconds</b>.<br/><br/>

        Because of this we don't know the exact time of when the <b>50 Million'th Ledger</b> will occur but
        for the purposes of this website we <b>average the <a :href="ledgers_closed_uri">number of ledgers closed</a> over the last
        few hours</b> and use the validation rate in combination with the remaining ledgers to project
        forward.<br/><br/>

        You will see jumpiness as we sync ledgers from the live network and the close
        time varies... <b>we apologize for any inconvenience...</b>
        </p>
      </b-modal>

      <div id="ledger_status_container" v-if="have_current_ledger">
        <span id="current_ledger">Current Ledger: {{current_ledger | delim}}</span><br/>
        <span id="remaining_ledgers">Remaining: {{remaining_ledgers | delim}} Ledgers</span><br/>
        <span id="projected_time">Projected Time: {{projected_time}}</span>
        <br/>
      </div>
    </div>

    <div id="contest_entry">
      <h3>To celebrate 50 Million, <b>we've created 5 XRP accounts and have locked away increasing prize amounts!</b></h3>
      <h4><b>Want to win a private key?!?</b> A series of 5 puzzles will be posted here, solve one to have a shot at the prize!</h4>
      <p><i>Make sure to have a pen & paper handy!</i></p>

      <div id="current_puzzle">
        <h2 style="color: blue"  v-if="puzzle_completed()">Puzzle Completed!</h2>
        <h2 style="color: red"  v-if="!puzzle_active()">New Puzzle Coming Soon!</h2>

        <div v-else>
          <h4 style="color: blue">Challenge #{{puzzle_number}} - Win {{puzzle_payout}} XRP!</h4>
          <p><b>Time Remaining</b>: {{puzzle_time_remaining}}</p>
          <img :src="puzzle_img" style="width: 100%;"/>
          <p style="margin: 0">Think you know the answer?! Email your submission to <a href="mailto:devnullproductions@gmail.com">Dev Null Productions</a>.</p>
          <p style="margin: 0">A random winner will be selected from the pool of correct answers.</p>
          <p style="color: red; margin: 0;">Only one submission accepted per email per challenge... so guess carefully!</p>
          <p style="font-size: 0.7em; margin: 0">By entering this contest you agree that you are of legal age and standing to participate in such giveaways and to possess the XRP Digital Asset.<br/>By entering this contest you absolve the organizers of any and all legal and financial liabilities</p>
        </div>
      </div>
    </div>

    <div id="contributors">
      <div class="contributor_container">
        <div class="contributor_header">
          <div class='contributor_label' style="color: #A8A7AE;">Platinum Sponsors:</div>
          <p><b>Expect new features from these Developers & Projects in celebration of the event!</b></p>
        </div>
        <ul class="contributor_list">
          <li class="contributor_list_item"><a href="https://devnull.network"><img src="@/assets/logo-dnp.png" class="contributor_icon" />Dev Null Productions</a></li>
          <li class="contributor_list_item"><a href="https://xrpscan.com"><img src="@/assets/logo-xrpscan.png" class="contributor_icon" />XRP Scan</a></li>
          <li class="contributor_list_item"><a href="https://bithomp.com"><img src="@/assets/logo-bithomp.png" class="contributor_icon" />Bithomp</a></li>
          <li class="contributor_list_item"><a href="https://rabbitkick.club/"><img src="@/assets/logo-rkc.png" class="contributor_icon" />Rabbit Kick Club</a></li>
          <li class="contributor_list_item"><a href="https://xrptipbot-statistics.siedentopf.xyz"><img src="@/assets/logo-nixerffm.png" class="contributor_icon" />XRPTipBot-Stats</a></li>
          <li class="contributor_list_item"><a href="https://www.xrptoolkit.com/"><img src="@/assets/logo-xrptoolkit.png" class="contributor_icon" />XRP Toolkit</a></li>
        </ul>
      </div>

      <div class="contributor_container">
        <div class="contributor_header">
          <div class='contributor_label' style="color: gold;">Gold Level Contributors:</div>
          <p><b>Many thanks to these awesome supporters</b></p>
        </div>
        <ul class='contributor_list'>
          <li class="contributor_list_item"><a href="https://twitter.com/wietsewind"><img src="@/assets/logo-wietse.png" class="contributor_icon" />Wietse Wind</a></li>
          <li class="contributor_list_item"><a href="https://twitter.com/Silkjaer"><img src="@/assets/logo-silkjaer.png"  class="contributor_icon"/>Thomas Silkjaer</a></li>
          <li class="contributor_list_item"><a href="https://twitter.com/jeremy_87110"><img src="@/assets/logo-nooneyouknow.png"  class="contributor_icon"/>Jeremy87110</a></li>
          <li class="contributor_list_item"><a href="https://twitter.com/KevinKing64"><img src="@/assets/logo-kevinking.png"  class="contributor_icon"/>KevinKing64</a></li>
          <li class="contributor_list_item"><a href="https://twitter.com/PaperStProjects"><img src="@/assets/logo-paperstprojects.png"  class="contributor_icon"/>PaperStProjects</a></li>
          <li class="contributor_list_item"><a href="https://twitter.com/XRPeezy"><img src="@/assets/logo-xrpeezy.png"  class="contributor_icon"/>XRPeezy</a></li>
        </ul>
      </div>

      <div class="contributor_container" style="display: flex; flex-direction: column; justify-content: center;">
        <div class="contributor_header">
          <div class='contributor_label' style="color: #cd7f32">Community Level Supporters:</div>
          <p><b>Too many to list here but we thank you all!</b></p>
        </div>
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
    return {current_ledger : 0,
            rate : 0,
            now : this.$moment(new Date()),
            remaining_offset : 0,
            ledgers_closed_uri : 'https://api.xrp1ntel.com/report/300?metrics=ledgers_closed',
            puzzle_number : 3,
            puzzle_payout : 150,
            puzzle_timeout :   new Date("2019-09-03T00:00:00Z"),
            puzzle_time_remaining : 0};
  },

  computed : {
    have_current_ledger : function(){
      return this.current_ledger > 0;
    },

    countdown_days : function(){
      var days = this.projected_time.diff(this.now, 'days');
      return days < 0 ? 0 : days;
    },

    countdown_hours : function(){
      var hours = this.projected_time.diff(this.now, 'hours') - this.countdown_days * 24;
      return hours < 0 ? 0 : hours;
    },

    countdown_mins : function(){
      var mins = this.projected_time.diff(this.now, 'minutes') - this.countdown_days * 24 * 60
                                                               - this.countdown_hours * 60;
      return mins < 0 ? 0 : mins;
    },

    countdown_secs : function(){
      var secs = this.projected_time.diff(this.now, 'seconds') - this.countdown_days * 24 * 60 * 60
                                                               - this.countdown_hours * 60 * 60
                                                               - this.countdown_mins * 60;
      return secs < 0 ? 0 : secs;
    },

    projected_time : function(){
      return this.now.clone().add(this.remaining_time, 'seconds');
    },

    remaining_time : function(){
      return this.remaining_ledgers / this.rate - this.remaining_offset;
    },

    remaining_ledgers : function(){
      return TARGET - this.current_ledger;
    },

    countdown_reached : function(){
      return this.remaining_ledgers <= 0;
    },

    puzzle_img : function(){
      return require('./assets/challenge' + this.puzzle_number + ".png");
    },
  },

  methods : {
    puzzle_active : function(){
      return !!this.puzzle_timeout && (new Date() < this.puzzle_timeout);
    },

    puzzle_completed : function(){
      return !!this.puzzle_timeout && (new Date() >= this.puzzle_timeout);
    },
  },

  ///

  created : function(){
    setInterval(function(){
      this.now = this.$moment(new Date());
      this.remaining_offset += 1;

      var ms = this.$moment(this.puzzle_timeout).diff(this.now);
      var d = this.$moment.duration(ms);
      this.puzzle_time_remaining = Math.floor(d.asHours()) + " Hours " + this.$moment.utc(ms).format("mm") + " Minutes " + this.$moment.utc(ms).format("ss") + " Seconds";
    }.bind(this), 1000);

    this.$options.sockets.onmessage = function(m){
      var data = JSON.parse(m.data);
      var ledger = data["ledger_index"];
      if(ledger){
        this.current_ledger = ledger;
        this.remaining_offset = 0;
      }
    }.bind(this);

    this.$options.sockets.onopen = function(){
      this.$socket.sendObj({command : 'subscribe', streams : ['ledger']})
    }.bind(this);

    // TODO periodically resync & only use last N data points
    this.$http.get(this.ledgers_closed_uri)
              .then(function(d){
                var ledgers = Object.values(d.body['ledgers_closed']);
                var sum = 0;
                for(var l = 0; l < ledgers.length; l++)
                  sum += parseInt(ledgers[l]);
                var avg = parseFloat(sum)/ledgers.length;
                this.rate = avg/300;
                this.remaining_offset = 0;
              }.bind(this));
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
  text-align: center;
  display: flex;
  flex-direction: column;
}

.blinking{
    animation:blinkingText 1.2s infinite;
}
@keyframes blinkingText{
    0%{     color: red;    }
    25%{   color: transparent; }
    50%{   color: blue;    }
    75%{   color: transparent; }
    100%{  color: red;    }
}

#countdown_container{
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;

  background-image: url('./assets/party.png');
  background-size: 100% 100%;
  color: white;
  padding: 25px;
}

.sm #countdown_container{
  padding: 10px;
}

#countdown_title{
  border-radius: 3px;
  background-color: rgba(48, 47, 47, 0.5);
  font-family: Lobster Two,cursive;
  font-size: 70px;
  margin-bottom: 0;
}

.sm #countdown_title{
  font-size: 32px;
}

#countdown_subtitle{
  background-color: rgba(48, 47, 47, 0.5);
  font-family: Lobster Two,cursive;
}

#subcountdown_container{
  display: flex;
  justify-content: center;
}

.sm #subcountdown_container{
  flex-direction: column;
}

.subcountdown_subcontainer{
  display: flex;
  justify-content: space-evenly;
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

.sm .subcountdown_counter{
  font-size: 1.5em;
}

.subcountdown_label{
  margin-top: 3px;
  padding: 5px;
  font-size: 1.4em;
  background: rgba(40,50,61,.62);
  font-family: Helvetica,Arial,Sans-Serif;
}

.sm .subcountdown_label{
  font-size: 0.8em
}

#how_computed{
  color: blue;
  font-family: Helvetica,Arial,Sans-Serif;
  font-size: 0.8em;
  cursor: pointer;
}

.sm #how_computed{
  font-size: 0.7em;
}

#ledger_status_container{
  font-family: Lobster Two;
  font-size: 30px;
  color: blue;
  font-weight: bold;
}

.sm #ledger_status_container{
  font-size: 16px;
}


#contest_entry{
  background-color: white;
  flex-grow: 1;
  padding: 25px;
}

.sm #contest_entry h3{
  font-size: 1.2em;
}

.sm #contest_entry h4{
  font-size: 0.9em;
}

#current_puzzle{
  min-height: 250px;
  border: 1px solid black;

  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 25px;
}

#contributors{
  background: blue;
  display: flex;
  justify-content: space-evenly;

  background-image: url('./assets/concert.jpg');
  background-size: 100% 100%;

  color: white;
  padding: 25px;
}

.sm #contributors{
  flex-direction: column;
  background-image: url('./assets/fireworks.jpg');
}

.contributor_container{
  background-color: rgba(0, 0, 0, 0.44);
  text-align: center;
  padding: 25px;
  width: 25%;
}

.sm .contributor_container{
  width: unset;
}

.contributor_header{
  min-height: 150px;
}

.contributor_label{
  font-weight: bold;
  font-size: 1.6em;
  min-height: 50px;
}

.contributor_list{
  list-style: none;
  border-top: 1px solid white;
  padding-top: 10px;
  padding-left: 0;
  text-align: left;
}

.sm .contributor_list{
  font-size: 0.9em;
}

.contributor_list_item{
  margin: 10px;
}

.contributor_list_item a,
.contributor_list_item a:hover{
  color: white;
}

.contributor_icon{
  width: 50px;
  height: 50px;
  margin-right: 10px;
}
</style>
