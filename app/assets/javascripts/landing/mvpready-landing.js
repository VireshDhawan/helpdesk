/* ========================================================
*
* MVP Ready - Lightweight & Responsive Admin Template
*
* ========================================================
*
* File: mvpready-landing.js
* Version: 1.0.0
* Author: Jumpstart Themes
* Website: http://mvpready.com
*
* ======================================================== */

var mvpready_landing = function () {

  "use strict"

  var initMastheadCarousel = function () {
    if (!$.fn.carousel) { return false }

    $('.masthead-carousel').carousel ({ interval: 10000 })
  }

  var initClientsCarousel = function () {
    if (!$.fn.carouFredSel) { return false }

    $('.clients-list').carouFredSel ({
      items: {
        visible: {
          min: 1,
          max: 5
        }
      },
      prev: {
        button: function() {
          return $(this).closest('.carousel-container').find('.carousel-prev')
        },
        key: "left"
      },
      next: {
        button: function() {
          return $(this).closest('.carousel-container').find('.carousel-next')
        },
        key: "right"
      },
      responsive: true,
      auto: false,
      scroll: {
        onAfter: function () {
          /**
          We have bug in chrome, and we need to force chrome to re-render specific portion of the page
          after it's complete the scrolling animation so this is why we add these dumb lines.
          */
          if (/chrome/.test(navigator.userAgent.toLowerCase())) {
            this.style.display = 'none'
            this.offsetHeight
            this.style.display = 'block'
          }

        },
        items: 1
      }
    }, {
      debug: false
    })
  }

	return {
		init: function () {
      mvpready_core.navHoverInit ({ delay: { show: 250, hide: 350 } })  

      initMastheadCarousel ()
      initClientsCarousel ()

			// Components
			mvpready_core.initAccordions ()
			mvpready_core.initTooltips ()
			mvpready_core.initBackToTop ()
		}
	}

} ()

$(function () {
	mvpready_landing.init ()
})