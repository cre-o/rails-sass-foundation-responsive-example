# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.

# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.

# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.

# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#= require jquery
#= require rails-ujs
#= require jquery.slick

jQuery ->
  # Main navigation menu logic
  $('.b-mobile-menu a').on 'click', ->
    if $(this).hasClass('open')
      $('.b-top-menu .b-menu').addClass('active')
      $(this).addClass('close').removeClass('open')
    else
      $('.b-top-menu .b-menu').removeClass('active')
      $(this).addClass('open').removeClass('close')

  $('.b-top-menu .b-menu > ul a').on 'click', ->
    $('.b-top-menu .b-menu').removeClass('active')
    $('.b-mobile-menu a').addClass('open').removeClass('close')

  # Main slider
  $('.b-slider').slick
    autoplay: true
    autoplaySpeed: 8000
    # adaptiveHeight: true

  # Restructurise slider on mobile screens
  $('.js-competences-nav li').on 'click', ->
    if $(window).width() < 640
      navItem = $(this)
      if navItem.hasClass('slick-current')
        navItem.children('.competences-cloned-row').remove()

        setTimeout ->
          navItem.removeClass('slick-current')
        , 50
      else
        setTimeout ->
          navItem.addClass('slick-current')
        , 50

        if $(this).children('.competences-cloned-row').length == 0
          copy = $('.js-competences-slider .slick-current').html()
          container = $('<div class="competences-cloned-row">'+copy+'</div')
          navItem.append(container)

  # Navigation for competences slider
  $('.js-competences-nav ul').slick
    slidesToShow: 99
    slidesToScroll: 1
    asNavFor: '.js-competences-slider'
    focusOnSelect: true
    dots: false
    arrows: false
    useTransform: false
    swipe: false
    touchMove: false

  # Competences slider initialisation
  competencesSlider = $('.js-competences-slider').slick
    asNavFor: '.js-competences-nav ul'
    slidesToShow: 1
    slidesToScroll: 1
    autoplay: false
    prevArrow: '.b-competences .b-article .controlls a.go-back'
    nextArrow: '.b-competences .b-article .controlls a.go-next'
    swipe: false
    touchMove: false

  # Removing default slide screen on click
  $('.b-competences a').on 'click', ->
    $('.js-competences-slider').removeClass('hide')

  $('.js-default-competence').on 'click', ->
    competencesSlider.slick('slickGoTo', 0)

  # Do not goto anchor on click pls
  $('.js-unclick').on 'click', (e) ->
    history.pushState(null, null, $(this).attr('href'));
    e.preventDefault();

  if $('.js-competences-nav .slick-slide:last-child a').attr('href') != '#kompetenzen-zwangsvollstreckung----forderungsbeitreibung'
    $('.js-competences-nav .slick-track').addClass('changed-order')


  changeDefaultMenuState = ->
    if $('.js-competences-nav li .slick-current').find('.competences-cloned-row').length == 0
      $('.js-competences-nav li').removeClass('slick-current')

  # Hides inactive slides on window resize
  $(window).resize ->

    if $(window).width() < 640
      $('.js-competences-slider .slide').addClass('opacity-0')
      changeDefaultMenuState()
    else
      setTimeout ->
        $('.js-competences-slider .slide').removeClass('opacity-0')
      , 300

  # Set current tab from hash
  hash = $(location).attr('hash')
  if hash.substring(0,12) == '#kompetenzen'
    # show navigation
    lookingFor = $(".js-competences-nav a[href='#{hash}']")
    lookingFor.parent().addClass('slick-current')
    currentSlideId = parseInt(lookingFor.data('slide-id')) - 1 # 0 is the first one
    competencesSlider.slick('slickGoTo', currentSlideId, true)

  # <-- Competences slider

  # User team slider -->
  $( '.js-team-nav' ).slick
    slidesToShow: 4,
    slidesToScroll: 1,
    focusOnSelect: true,
    dots: false,
    useTransform: false,
    swipe: false,
    touchMove: false


  $( '.b-our-team' ).hover ->
    $( '.js-team-nav .slick-prev, .js-team-nav .slick-next' ).addClass('visible')
  , ->
    $( '.js-team-nav .slick-prev, .js-team-nav .slick-next' ).removeClass('visible')

  teamGallery = $('.b-lawyers .js-team-slider').slick
    slidesToShow: 1
    slidesToScroll: 1

    autoplay: false
    fade: true
    speed: 500
    prevArrow: '.b-lawyers .js-controlls a.go-back'
    nextArrow: '.b-lawyers .js-controlls a.go-next'
    zIndex: 100
    swipe: false
    touchMove: false


  $('.js-goto-person').on 'click', (e) ->
    teamGallery.slick('slickGoTo', parseInt($(this).data('slide')) - 1)


  $('.big-card .contact-info a.opener').on 'click', ->
    if $(this).hasClass('open')
      $(this).parent().next().addClass('show-for-large')
      $(this).removeClass('open')
    else
      $(this).addClass('open')
      $(this).parent().next().removeClass('show-for-large')

  # <-- User team slider

  # Kontakt >
  $('form').on 'click', '.wpcf7-not-valid-tip', ->
    $(this).prev().focus()
    $(this).remove()
  # < Kontakt

  # Impressum -->
  $('.js-impressum-pages ul').slick
    slidesToShow: 99
    slidesToScroll: 1
    asNavFor: '.js-impressum-slider'
    focusOnSelect: true
    dots: false
    arrows: false
    useTransform: false
    swipe: false
    touchMove: false

  # Competences slider initialisation
  $('.js-impressum-slider').slick
    asNavFor: '.js-impressum-pages ul'
    slidesToShow: 1
    slidesToScroll: 1
    autoplay: false
    adaptiveHeight: true
    arrows: false
    fade: true
    speed: 500
    swipe: false
    touchMove: false

  $('.js-impressum-pages .slick-list a').on 'click', ->
    $('.js-impressum-pages .slick-list a').removeClass('current')
    $(this).addClass('current')

  if hash == '#impressum' then $('#impressum').removeClass('hide')

  $('a[href$="#impressum"]').on 'click', ->
    $('#karriere').addClass('hide')
    $('#impressum').removeClass('hide')
    $('.js-impressum-slider').slick('refresh')

  # <-- Impressum

  # Karriere ->>

  if hash == '#karriere' then $('#karriere').removeClass('hide')

  $('a[href$="#karriere"]').on 'click', ->
    $('#impressum').addClass('hide')
    $('#karriere').removeClass('hide')

  $('.b-career .sub-nav a.menu-item').on 'click', ->
    displaySection = $(this).data('show')
    $('.b-career .sub-nav a.menu-item').removeClass('active')
    $(this).addClass('active')

    if displaySection == 'career-info'
      $('.b-career section.career-form').addClass('hide')
      $('.b-career section.career-info').removeClass('hide')
    else
      $('.b-career section.career-info').addClass('hide')
      $('.b-career section.career-form').removeClass('hide')
  # Menu

  # <<-- Karriere

  # GoToTop
  if $('#back-to-top').length
    scrollTrigger = 100

    backToTop = ->
      scrollTop = $(window).scrollTop()
      if scrollTop > scrollTrigger
        $('#back-to-top').addClass 'show'
      else
        $('#back-to-top').removeClass 'show'

    backToTop()
    $(window).on 'scroll', ->
      backToTop()

    $('#back-to-top').on 'click', (e) ->
      e.preventDefault()
      $('html,body').animate { scrollTop: 0 }, 700




