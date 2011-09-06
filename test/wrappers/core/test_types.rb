
require 'test/setup'
require 'opencv-ffi/core'
require 'opencv-ffi-wrappers/core'

class TestCoreTypesWrappers < Test::Unit::TestCase

  def test_cvSizeWrappers
    p = CVFFI::CvSize.new( {:width => 1, :height => 2} )

    assert_equal 1, p.x
    assert_equal 2, p.y

    assert_equal 1, p.width
    assert_equal 2, p.height

    p.x = 3

    assert_equal 3, p.width
    assert_equal 2, p.height
    assert_equal 3, p.x
    assert_equal 2, p.y

    r = p.to_CvSize
    assert_equal p,r

    q = p.to_CvSize2D32f
    assert_in_delta 3.0, q.width, TestSetup::EPSILON
    assert_in_delta 2.0, q.height, TestSetup::EPSILON
  end

  def test_size
    p = CVFFI::Size.new( [4.0, 5.0] )

    assert_equal 4.0, p.width
    assert_equal 5.0, p.height

    assert_in_delta 20.0, p.area, TestSetup::EPSILON

    q = p.to_CvSize2D32f
    assert q.is_a?( CVFFI::CvSize2D32f )
    assert_in_delta 4.0, q.width, TestSetup::EPSILON
    assert_in_delta 5.0, q.height, TestSetup::EPSILON

    r = CVFFI::Size.new p
    assert_equal 4.0, r.width
    assert_equal 5.0, r.height

    s = p/2.0
    assert_equal 2.0, s.width
    assert_equal 2.5, s.height

    p *= 2.0
    assert_equal 8.0, p.width
    assert_equal 10.0, p.height
  end

  def test_point
    p = CVFFI::Point.new( 10.0, 0.0 )

    assert_equal 10.0, p.x
    assert_equal  0.0, p.y

    q = p.rotate( 0.0 )
    assert_equal 10.0, q.x
    assert_equal  0.0, q.y

    q = p.rotate( Math::PI/2.0 )
    assert_in_delta 0.0, q.x, TestSetup::EPSILON
    assert_in_delta 10.0, q.y, TestSetup::EPSILON
  end

  def test_iplimage
    img = CVFFI::cvCreateImage( CVFFI::CvSize.new( :width=>100, :height=>100 ), 8, 1 )

    size = img.image_size

    assert_not_nil size
    assert_equal 100, size.width
    assert_equal 100, size.height

  end

end
