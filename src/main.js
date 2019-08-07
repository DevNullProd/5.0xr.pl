import Vue from 'vue'
import App from './App.vue'

Vue.config.productionTip = false

///

Vue.use(require('vue-moment'));

///

import BootstrapVue from 'bootstrap-vue'
Vue.use(BootstrapVue)

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

///

import VueResource   from 'vue-resource'
Vue.use(VueResource)

import VueNativeSock from 'vue-native-websocket'
Vue.use(VueNativeSock, "wss://s1.ripple.com:443", { format : 'json', reconnection : true })

///

Vue.filter('delim', function(value) {
  return parseFloat(value).toLocaleString()
});

///

new Vue({
  render: h => h(App),
}).$mount('#app')
