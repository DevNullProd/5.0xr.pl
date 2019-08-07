<template>
  <!-- TODO: fork me on github -->
  <div id="app">
    <div id="countdown_container">
      <h2 id="countdown_title">Countdown to<br/>50 Million XRP Ledgers!</h2>
      <h4 id="countdown_subtitle">A XRP Community Celebration</h4>

      <div class="text-center" v-if="!have_current_ledger">
        <b-spinner />
      </div>

      <div id="subcountdown_container" v-if="have_current_ledger">
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

      <div id="how_computed" v-b-modal.how_computed_modal>
        How is this computed?
      </div>

      <b-modal id="how_computed_modal" title="How is this computed?" ok-only>
        <p class="my-4">
        While the XRP Ledger implements <b>Deterministic Consensus Validation</b>,
        the actual duration is negotiated on a ledger-by ledger basis.
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
      <h2>To celebrate 50 Million, <b>we're giving away 50 XRP to 50 lucky winners!</b></h2>
      <div>To enter this contest simply fill out this form with a valid email and valid (<b>already activated</b>) XRP ledger address!</div>

       <b-container fluid class="p-3">
         <b-row class="m-3">
           <b-col cols=3>
             <label for="contest_email">Email</label>
           </b-col>

           <b-col>
             <b-form-input id="contest_email" v-model="contest_email" placeholder="Enter your email" type="email" :state="contest_email_valid"></b-form-input>
           </b-col>
         </b-row>

         <b-row class="m-3">
           <b-col cols=3>
             <label for="contest_account">XRP Account</label>
           </b-col>

           <b-col>
             <b-form-input id="contest_account" v-model="contest_account" placeholder="Enter your XRP account" :state="contest_account_valid"></b-form-input>
           </b-col>
         </b-row>

         <b-row>
           <b-col>
             <b-button :disabled="!contest_email_valid || !contest_account_valid">Submit</b-button>
           </b-col>
         </b-row>
       </b-container>

       <div id="contest_rules"  v-b-modal.contest_rules_modal>
         By submitting you are agreeing to the mumbo-jumbo
       </div>

      <b-modal id="contest_rules_modal" title="Contest Rules" ok-only>
        <p><i>You're actually reading this?!</i>&nbsp;<b>Awesome</b>!</p>

        <ul>
        <li>To have a chance at winning the prize amount, simply fill out the form on this page with a <b>valid email and valid XRP address</b></li>
        <li>For an email to be valid it must be able to accept incoming mail from systems related to our contest and allow you to follow links sent through such</li>
        <li>Emails from temporary and/or masking services will be rejected (eg. Guerrilla Mail, temp-mail, etc)</li>
        <li>For an XRP account to be valid it must already be activated and be in good state (satisfying minimum reserve requirements) upon contest entry</li>
        <li><b>ONLY ONE ENTRY PER INDIVIDUAL</b> - If we catch multiple entries being submitted on the behalf of one or more individuals they will all be rejected!</li>
        <li>Upon arrival of the 50 Million'th ledger, no more contest entries will be accepted and we will randomly pick 50 winners from the pool of valid entries</li>
        <li>Winners will be sent 50 XRP each via the specified accounts shortly after</li>
        <li><b>By entering this contest, you absolve the organizers of any and all legal and financial liabilities</b>. You are verifying that you are of legal age to participate in these sorts of contests and no other legal-barriers prohibit you from participating in this contest and/or accepting the rewards in your local, regional, and national jurisdictions.</li>
        <li>Contestants acknowledge that the rules may be changed at any time for any reason and/or participants may be disqualified for any reason. At no point should participants make any assumptions pertaining to the rules and/or results of the contest.</li>
        <li><b>Good luck!</b></li>
        </ul>



      </b-modal>
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
          <li class="contributor_list_item"><a href="https://bithomp.com"><img src="@/assets/logo-bithomp.png" class="contributor_icon" />BitHomp</a></li>
          <li class="contributor_list_item"><a href="https://rabbitkick.club/"><img src="@/assets/logo-rkc.png" class="contributor_icon" />Rabbit Kick Club</a></li>
          <li class="contributor_list_item"><a href="https://xrptipbot-statistics.siedentopf.xyz"><img src="@/assets/logo-nixerffm.png" class="contributor_icon" />nixerFFM (XRPTipBot-Stats)</a></li>
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
            contest_email : '',
            contest_account : '',
            contest_account_valid : null,
            contest_email_valid : null};
  },

  computed : {
    have_current_ledger : function(){
      return this.current_ledger > 0;
    },

    countdown_days : function(){
      return this.projected_time.diff(this.now, 'days');
    },

    countdown_hours : function(){
      return this.projected_time.diff(this.now, 'hours') - this.countdown_days * 24;
    },

    countdown_mins : function(){
      return this.projected_time.diff(this.now, 'minutes') - this.countdown_days * 24 * 60
                                                           - this.countdown_hours * 60;
    },

    countdown_secs : function(){
      return this.projected_time.diff(this.now, 'seconds') - this.countdown_days * 24 * 60 * 60
                                                           - this.countdown_hours * 60 * 60
                                                           - this.countdown_mins * 60;
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
  },

  ///

  watch : {
    contest_account : function(){
      if(this.contest_account == ""){
        this.contest_account_valid = null;
        return;
      }

      this.contest_account_valid = false;
      this.$socket.sendObj({'command' : 'account_info', 'account' : this.contest_account});
    },

    contest_email : function(){
      if(this.contest_email == ""){
        this.contest_email_valid = null;
        return;
      }

      this.contest_email_valid =  (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(this.contest_email));
    }
  },

  created : function(){
    setInterval(function(){
      this.now = this.$moment(new Date());
      this.remaining_offset += 1;
    }.bind(this), 1000);

    this.$options.sockets.onmessage = function(m){
      var data = JSON.parse(m.data);
      if(data["result"] && data["result"]["account_data"]){
console.log("!")
        this.contest_account_valid = true;
        return;
      }

      var ledger = data["ledger_index"];
      if(ledger)
        this.current_ledger = ledger;
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
}

#countdown_title{
  border-radius: 3px;
  background-color: rgba(48, 47, 47, 0.5);
  font-family: Lobster Two,cursive;
  font-size: 70px;
  margin-bottom: 0;
}

#countdown_subtitle{
  background-color: rgba(48, 47, 47, 0.5);
  font-family: Lobster Two,cursive;
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

#how_computed{
  color: blue;
  font-family: Helvetica,Arial,Sans-Serif;
  font-size: 0.8em;
  cursor: pointer;
}

#ledger_status_container{
  font-family: Lobster Two;
  font-size: 30px;
  color: blue;
  font-weight: bold;
}

#contest_entry{
  background-color: white;
  flex-grow: 1;
  padding: 25px;
  min-height: 450px;
}

#contest_rules{
  font-size: 0.6em;
  color: blue;
  font-family: Helvetica,Arial,Sans-Serif;
  cursor: pointer;
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

.contributor_container{
  background-color: rgba(0, 0, 0, 0.44);
  text-align: center;
  padding: 25px;
  width: 25%;
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
  text-align: justify;
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
