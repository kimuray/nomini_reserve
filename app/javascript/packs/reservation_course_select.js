import Vue from 'vue/dist/vue.esm';
import $ from 'jquery/dist/jquery.min';

new Vue({
  el: '#js_reservation_course_select',
  created() {
    if($("#reservation_alacarte").prop('checked')) {
      this.$data.showCourse = false;
    }
  },
  data: {
    showCourse: true
  },
});
