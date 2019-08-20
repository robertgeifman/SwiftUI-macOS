import AppKit
import Combine
import CoreFoundation
import CoreGraphics
import CoreText
import Darwin
import Foundation
import SwiftUI
import os.log
import os
import os.signpost

/// The type of an Accessibility action. Includes name information for custom
/// actions
public struct AccessibilityActionType : Equatable {
	public static let `default`: AccessibilityActionType
	public static let escape: AccessibilityActionType
	public static let magicTap: AccessibilityActionType
	public init(named name: Text)
}

/// Specifies which way an adjustment should be made.
public enum AccessibilityAdjustmentDirection {
	case increment
	case decrement
}

/// A view modifier that adds accessibility properties to the view.
public struct AccessibilityModifier {
	/// The type of view representing the body of `Self`.
	public typealias Body = Never
}

extension AccessibilityModifier : ViewModifier {
}

/// Defines the behavior for the child elements of the new parent element
public struct AccessibilityParentBehavior : Hashable {
}

extension AccessibilityParentBehavior {
	/// Any child accessibility elements become children of the new accessibility element
	public static let contain: AccessibilityParentBehavior

	/// Combine any child accessibility element's properties for the new accessibility element
	public static let combine: AccessibilityParentBehavior
}

public struct AccessibilityTraits : SetAlgebra {
	public static let isButton: AccessibilityTraits
	public static let isHeader: AccessibilityTraits
	public static let isSelected: AccessibilityTraits
	public static let isLink: AccessibilityTraits
	public static let isSearchField: AccessibilityTraits
	public static let isImage: AccessibilityTraits
	public static let playsSound: AccessibilityTraits
	public static let isKeyboardKey: AccessibilityTraits
	public static let isStaticText: AccessibilityTraits
	public static let isSummaryElement: AccessibilityTraits
	public static let updatesFrequently: AccessibilityTraits
	public static let startsMediaSession: AccessibilityTraits
	public static let allowsDirectInteraction: AccessibilityTraits
	public static let causesPageTurn: AccessibilityTraits
	public static let isModal: AccessibilityTraits

	public init()

	/// A type for which the conforming type provides a containment test.
	public typealias Element = AccessibilityTraits

	/// The type of the elements of an array literal.
	public typealias ArrayLiteralElement = AccessibilityTraits
}

public enum AccessibilityVisibility {
	/// visible, children not visible
	case element

	/// macOS - visible, children visible, iOS - not visible, children visible
	case containerElement

	/// not visible, children visible
	case container

	/// not visible, children not visible
	case hidden
}

/// A storage type for an alert presentation.
public struct Alert {
	/// Creates an alert with one button.
	public init(title: Text, message: Text? = nil, dismissButton: Alert.Button = .default(Text("OK")))

	/// Creates an alert with two buttons.
	///  - Note: the system determines the visual ordering of the buttons.
	public init(title: Text, message: Text? = nil, primaryButton: Alert.Button, secondaryButton: Alert.Button)

	/// A button representing an operation of an alert presentation.
	public struct Button {
		/// Creates an `Alert.Button` with the default style.
		public static func `default`(_ label: Text, onTrigger: (() -> Void)? = {}) -> Alert.Button

		/// Creates an `Alert.Button` that indicates cancellation of some
		/// operation.
		///
		/// - Note: the label of the button is automatically chosen by the
		/// system for the appropriate locale.
		public static func cancel(_ onTrigger: (() -> Void)? = {}) -> Alert.Button

		/// Creates an `Alert.Button` with a style indicating destruction of
		/// some data.
		public static func destructive(_ label: Text, onTrigger: (() -> Void)? = {}) -> Alert.Button
	}
}

/// An alignment in both axes.
public struct Alignment : Equatable {
	public var horizontal: HorizontalAlignment
	public var vertical: VerticalAlignment

	@inlinable public init(horizontal: HorizontalAlignment, vertical: VerticalAlignment)
	public static let center: Alignment
	public static let leading: Alignment
	public static let trailing: Alignment
	public static let top: Alignment
	public static let bottom: Alignment
	public static let topLeading: Alignment
	public static let topTrailing: Alignment
	public static let bottomLeading: Alignment
	public static let bottomTrailing: Alignment
}

/// Types used to identify alignment guides.
///
/// Every type conforming to `AlignmentID` has a corresponding alignment guide
/// value, usually declared as a static constant property of
/// `HorizontalAlignment` or `VerticalAlignment`.
public protocol AlignmentID {
	/// Returns the value of the corresponding guide, in `context`, when not
	/// otherwise set in `context`.
	static func defaultValue(in context: ViewDimensions) -> Length
}

/// An opaque value derived from an `Anchor<Value>.Source` and a
/// particular view. It may be converted to a `Value` in the coordinate
/// space of a target view, using a `LayoutContext` to specify the
/// target view.
public struct Anchor<Value> : Equatable where Value : Equatable {

	/// A type-erased geometry value that produces an anchored value of
	/// type `Value`. Anchored geometry values are passed around the
	/// view tree via preference keys, and then converted back into the
	/// local coordinate via a LayoutContext, e.g. in a layout's
	/// situate() function.
	public struct Source : Equatable {
	}
}

extension Anchor.Source {
	public init<T>(_ array: [Anchor<T>.Source]) where Value == [T], T : Equatable
}

extension Anchor.Source {
	public init<T>(_ anchor: Anchor<T>.Source?) where Value == T?, T : Equatable
}

extension Anchor.Source where Value == CGPoint {
	public static func point(_ p: CGPoint) -> Anchor<Value>.Source
	public static func unitPoint(_ p: UnitPoint) -> Anchor<Value>.Source
	public static var topLeading: Anchor<CGPoint>.Source { get }
	public static var top: Anchor<CGPoint>.Source { get }
	public static var topTrailing: Anchor<CGPoint>.Source { get }
	public static var leading: Anchor<CGPoint>.Source { get }
	public static var center: Anchor<CGPoint>.Source { get }
	public static var trailing: Anchor<CGPoint>.Source { get }
	public static var bottomLeading: Anchor<CGPoint>.Source { get }
	public static var bottom: Anchor<CGPoint>.Source { get }
	public static var bottomTrailing: Anchor<CGPoint>.Source { get }
}

extension Anchor.Source where Value == CGRect {
	/// Returns an anchor source rect defined by `r` in the current view.
	public static func rect(_ r: CGRect) -> Anchor<Value>.Source

	/// An anchor source rect defined as the entire bounding rect of the
	/// current view.
	public static var bounds: Anchor<CGRect>.Source { get }
}

/// Paint adaptor to override the unit space to absolute space
/// coordinate conversion.
public struct AnchoredShapeStyle<S> : ShapeStyle where S : ShapeStyle {
	public var style: S
	public var bounds: CGRect
}

/// A geometric angle whose value can be accessed either in radians or degrees.
public struct Angle {
	public var radians: Double

	@inlinable public var degrees: Double

	@inlinable public init()

	@inlinable public init(radians: Double)

	@inlinable public init(degrees: Double)

	@inlinable public static func radians(_ radians: Double) -> Angle

	@inlinable public static func degrees(_ degrees: Double) -> Angle
}

extension Angle : Hashable, Comparable {
	/// Returns a Boolean value indicating whether the value of the first
	/// argument is less than that of the second argument.
	///  This function is the only requirement of the `Comparable` protocol. The
	/// remainder of the relational operator functions are implemented by the
	/// standard library for any type that conforms to `Comparable`.
	///  - Parameters:
	///   - lhs: A value to compare.
	///   - rhs: Another value to compare.
	@inlinable public static func < (lhs: Angle, rhs: Angle) -> Bool
}

extension Angle : Animatable {
	/// The data to be animated.
	public var animatableData: Double

	@inlinable public static var zero: Angle { get }

	/// The type defining the data to be animated.
	public typealias AnimatableData = Double
}

/// An angular gradient (sometimes also known as a conic gradient). The
/// gradient's color function is applied as the angle changes, relative
/// to a center point and defined start and end angles. If `endAngle -
/// startAngle` > 2pi only the last complete turn is drawn. If
/// `endAngle - startAngle < 2pi` the missing area is filled with the
/// colors defined by gradient locations one and zero, transitioning
/// between the two halfway across the missing area. The unit-space
/// center point is mapped into the bounding rectangle of each shape
/// filled with the gradient.
public struct AngularGradient : ShapeStyle {
	public init(gradient: Gradient, center: UnitPoint, startAngle: Angle = .zero, endAngle: Angle = .zero)
	public init(gradient: Gradient, center: UnitPoint, angle: Angle = .zero)
}

/// A type that can be animated
public protocol Animatable {
	/// The type defining the data to be animated.
	associatedtype AnimatableData : VectorArithmetic

	/// The data to be animated.
	var animatableData: Self.AnimatableData { get set }
}

extension Animatable where Self : VectorArithmetic {
	public var animatableData: Self
}

extension Animatable where Self.AnimatableData == EmptyAnimatableData {
	public var animatableData: EmptyAnimatableData
}

/// A modifier that can animatedly create another modifier.
public protocol AnimatableModifier : Animatable, ViewModifier {
}

/// A pair of animatable values, which is itself animatable.
public struct AnimatablePair<First, Second> : VectorArithmetic where First : VectorArithmetic, Second : VectorArithmetic {
	/// The first value.
	public var first: First

	/// The second value.
	public var second: Second

	/// Initializes with `first` and `second`.
	@inlinable public init(_ first: First, _ second: Second)
}

public struct Animation {
}

extension Animation {
	public static let `default`: Animation
}

extension Animation {
	public static func fluidSpring(stiffness: Double = 100, dampingFraction: Double = 1, blendDuration: Double = 0, timestep: Double = 1.0 / 300.0, idleThreshold: Double = 0.5) -> Animation
}

extension Animation {
	public func repeatCount(_ repeatCount: Int, autoreverses: Bool = true) -> Animation
	public func repeatForever(autoreverses: Bool = true) -> Animation
}

extension Animation {
	public static func basic(duration: Double = 0.35, curve: BasicAnimationTimingCurve = .easeInOut) -> Animation
}

extension Animation {
	public static func spring(mass: Double = 1.0, stiffness: Double = 100.0, damping: Double = 10.0, initialVelocity: Double = 0.0) -> Animation
}

extension Animation {
	public func delay(_ delay: Double) -> Animation
}

extension Animation {
	/// Returns an animation that has its speed multiplied by `speed`. For
	/// example, if you had `oneSecondAnimation.speed(0.25)`, it would be at
	/// 25% of its normal speed, so you would have an animation that would last
	/// 4 seconds.
	public func speed(_ speed: Double) -> Animation
}

extension Animation {
	public static let empty: Animation
}

extension Animation : CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
}

extension Animation : Equatable {
}

public struct AnyGesture<Value> {
	public init<T>(_ gesture: T) where Value == T.Value, T : Gesture

	public typealias Body = Never
}

extension AnyGesture : Gesture {
}

/// A type-erased `PopUpButtonStyle`.
public struct AnyPopUpButtonStyle {
}

extension AnyPopUpButtonStyle {
	/// The system default `PopUpButtonView` style.
	public static let `default`: AnyPopUpButtonStyle

	/// The system prominent `PullDownButtonView` style.
	public static let prominent: AnyPopUpButtonStyle

	/// The system plain `PopUpButtonView` style.
	public static let plain: AnyPopUpButtonStyle

	/// Plain, with configurable "arrows"
	public static func plain(showArrows: Bool) -> AnyPopUpButtonStyle
}

/// A type-erased `PullDownButtonStyle`.
public struct AnyPullDownButtonStyle {
}

extension AnyPullDownButtonStyle {
	/// The system default `PullDownButtonView` style.
	public static let `default`: AnyPullDownButtonStyle

	/// The system prominent `PullDownButtonView` style.
	public static let prominent: AnyPullDownButtonStyle

	/// The system plain `PullDownButtonView` style.
	public static let plain: AnyPullDownButtonStyle

	/// Plain, with configurable "arrows"
	public static func plain(showArrows: Bool) -> AnyPullDownButtonStyle
}

/// A type-erased `SliderStyle`.
public struct AnySliderStyle {
}

extension AnySliderStyle {
	/// The system default `Slider` style.
	public static let `default`: AnySliderStyle
}

/// A type-erased `Transition`.
public struct AnyTransition {
}

extension AnyTransition {
	/// A transition that inserts by moving in from the leading edge, and
	/// removes by moving out towards the trailing edge.
	///  - SeeAlso: `AnyTransition.move(edge:)`
	public static var slide: AnyTransition { get }
}

extension AnyTransition {
	public static func offset(_ offset: CGSize) -> AnyTransition
}

extension AnyTransition {
	/// A composite `Transition` that gives the result of two transitions both
	/// applied.
	public func combined(with other: AnyTransition) -> AnyTransition
}

extension AnyTransition {
	public static func scale(scale: Length = 0.0, anchor: UnitPoint = .center) -> AnyTransition
}

extension AnyTransition {
	/// A transition from transparent to opaque on insertion and opaque to
	/// transparent on removal.
	public static let opacity: AnyTransition
}

extension AnyTransition {
	/// A transition defined between an active modifier and an identity
	/// modifier.
	public static func modifier<E>(active: E, identity: E) -> AnyTransition where E : ViewModifier
}

extension AnyTransition {
	/// A composite `Transition` that uses a different transition for
	/// insertion versus removal.
	public static func asymmetric(insertion: AnyTransition, removal: AnyTransition) -> AnyTransition
}

extension AnyTransition {
	/// A transition that returns the input view, unmodified, as the output
	/// view.
	public static let identity: AnyTransition
}

extension AnyTransition {
	/// A transition that moves the view away towards the specified `edge` by
	/// the size of the view.
	public static func move(edge: Edge) -> AnyTransition
}

extension AnyTransition {
	/// Attach an animation to this transition.
	public func animation(_ animation: Animation?) -> AnyTransition
}

/// A type-erased `View`.
///
/// An `AnyView` allows changing the type of view used in a given view
/// hierarchy. Whenever the type of view used with an `AnyView`
/// changes, the old hierarchy is destroyed and a new hierarchy is
/// created for the new type.
public struct AnyView : View {
	/// Create an instance that type-erases `view`.
	public init<V>(_ view: V) where V : View

	public typealias Body = Never
}

/// A representation of the theme used to construct the appearance of views in
/// a view hierarchy: affecting controls, colors, etc.
/// An Appearance can be set in the Environment for some subtree, and the value
/// itself is late-binding such that an it can resolve differently based on the
/// Environment it is used within (e.g. affected by the Increased Constrast
/// setting.)
public struct Appearance : Hashable {
}

extension Appearance {
	/// The standard system light appearance
	/// Dynamically changes based on graphite and increased contrast settings
	public static let light: Appearance

	/// The standard system dark appearance
	/// Dynamically changes based on graphite and increased contrast settings
	public static let dark: Appearance
}

/// Keys for named colors (aka catalog colors) within an appearance
/// These colors are named and used based on semantics, e.g. "label color"
public struct AppearanceColorName : RawRepresentable, Hashable {
	/// System defined colors
	/// The borderless text color when in key selection background contexts
	public static let keySelectionText: AppearanceColorName

	/// The borderless text color when in a scrollable content background
	public static let controlText: AppearanceColorName
	public static let label: AppearanceColorName
	public static let secondaryLabel: AppearanceColorName
	public static let tertiaryLabel: AppearanceColorName
	public static let quaternaryLabel: AppearanceColorName

	public typealias RawValue = String
}

public enum BasicAnimationTimingCurve : Equatable {
	case easeInOut
	case easeIn
	case easeOut
	case linear
	case custom(Double, Double, Double, Double)
}

/// A type of object that serves notifies the framework when changed.
public protocol BindableObject : AnyObject, DynamicViewProperty, Identifiable, _BindableObjectViewProperty {
	/// A type that publishes an event when the object has changed.
	associatedtype PublisherType : Publisher where Self.PublisherType.Failure == Never

	/// An instance that publishes an event when the object has changed.
	///  A `View`'s subhierarchy is forcibly invalidated whenever
	/// the `didChange` of its `model` publishes an event.
	var didChange: Self.PublisherType { get }
}

extension BindableObject {
	/// Creates a `Binding` to a value semantic property of a reference type.
	///  If `Value` is not value semantic, the updating behavior for any views
	/// that make use of the resulting `Binding` is unspecified.
	public subscript<T>(keyPath: ReferenceWritableKeyPath<Self, T>) -> Binding<T> { get }
}

/// A value and a means to mutate it.
@propertyDelegate public struct Binding<Value> {
	/// The transaction used for any changes to the binding's value.
	public var transaction: Transaction

	/// The value referenced by the binding. Assignments to the value
	/// will be immediately visible on reading (assuming the binding
	/// represents a mutable location), but the view changes they cause
	/// may be processed asynchronously to the assignment.
	public var value: Value { get nonmutating set }

	/// Initializes from functions to read and write the value.
	public init(getValue: @escaping () -> Value, setValue: @escaping (Value) -> Void)

	/// Initializes from functions to read and write the value.
	public init(getValue: @escaping () -> Value, setValue: @escaping (Value, Transaction) -> Void)

	/// Creates a binding with an immutable `value`.
	public static func constant(_ value: Value) -> Binding<Value>
}

extension Binding : DynamicViewProperty {
}

/// Bindings are trivially BindingConvertible.
extension Binding : BindingConvertible {
	/// A binding to the persistent storage of `self`.
	@inlinable public var binding: Binding<Value> { get }
}

extension Binding : Sequence where Value : MutableCollection, Value.Index : Hashable {
	/// A type representing the sequence's elements.
	public typealias Element = Binding<Value.Element>

	/// A type that provides the sequence's iteration interface and
	/// encapsulates its iteration state.
	public typealias Iterator = IndexingIterator<Binding<Value>>

	/// A sequence that represents a contiguous subrange of the collection's
	/// elements.
	///  This associated type appears as a requirement in the `Sequence`
	/// protocol, but it is restated here with stricter constraints. In a
	/// collection, the subsequence should also conform to `Collection`.
	public typealias SubSequence = Slice<Binding<Value>>
}

extension Binding : Collection where Value : MutableCollection, Value.Index : Hashable {
	/// A type that represents a position in the collection.
	///  Valid indices consist of the position of every element and a
	/// "past the end" position that's not valid for use as a subscript
	/// argument.
	public typealias Index = Value.Index

	/// A type that represents the indices that are valid for subscripting the
	/// collection, in ascending order.
	public typealias Indices = Value.Indices

	/// The position of the first element in a nonempty collection.
	///  If the collection is empty, `startIndex` is equal to `endIndex`.
	public var startIndex: Value.Index { get }

	/// The collection's "past the end" position---that is, the position one
	/// greater than the last valid subscript argument.
	///  When you need a range that includes the last element of a collection, use
	/// the half-open range operator (`..<`) with `endIndex`. The `..<` operator
	/// creates a range that doesn't include the upper bound, so it's always
	/// safe to use with `endIndex`. For example:
	/// 	let numbers = [10, 20, 30, 40, 50]
	///     if let index = numbers.firstIndex(of: 30) {
	///         print(numbers[index ..< numbers.endIndex])
	///     }
	///     // Prints "[30, 40, 50]"
	///  If the collection is empty, `endIndex` is equal to `startIndex`.
	public var endIndex: Value.Index { get }

	/// Returns the position immediately after the given index.
	///  The successor of an index must be well defined. For an index `i` into a
	/// collection `c`, calling `c.index(after: i)` returns the same index every
	/// time.
	///  - Parameter i: A valid index of the collection. `i` must be less than
	///   `endIndex`.
	/// - Returns: The index value immediately after `i`.
	public func index(after i: Binding<Value>.Index) -> Binding<Value>.Index

	/// Replaces the given index with its successor.
	///  - Parameter i: A valid index of the collection. `i` must be less than
	///   `endIndex`.
	public func formIndex(after i: inout Binding<Value>.Index)

	/// Accesses the element at the specified position.
	///  The following example accesses an element of an array through its
	/// subscript to print its value:
	/// 	var streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
	///     print(streets[1])
	///     // Prints "Bryant"
	///  You can subscript a collection with any valid index other than the
	/// collection's end index. The end index refers to the position one past
	/// the last element of a collection, so it doesn't correspond with an
	/// element.
	///  - Parameter position: The position of the element to access. `position`
	///   must be a valid index of the collection that is not equal to the
	///   `endIndex` property.
	///  - Complexity: O(1)
	public subscript(position: Binding<Value>.Index) -> Binding<Value>.Element { get }

	/// The indices that are valid for subscripting the collection, in ascending
	/// order.
	///  A collection's `indices` property can hold a strong reference to the
	/// collection itself, causing the collection to be nonuniquely referenced.
	/// If you mutate the collection while iterating over its indices, a strong
	/// reference can result in an unexpected copy of the collection. To avoid
	/// the unexpected copy, use the `index(after:)` method starting with
	/// `startIndex` to produce indices instead.
	/// 	var c = MyFancyCollection([10, 20, 30, 40, 50])
	///     var i = c.startIndex
	///     while i != c.endIndex {
	///         c[i] /= 5
	///         i = c.index(after: i)
	///     }
	///     // c == MyFancyCollection([2, 4, 6, 8, 10])
	public var indices: Value.Indices { get }
}

extension Binding : BidirectionalCollection where Value : BidirectionalCollection, Value : MutableCollection, Value.Index : Hashable {
	/// Returns the position immediately before the given index.
	///  - Parameter i: A valid index of the collection. `i` must be greater than
	///   `startIndex`.
	/// - Returns: The index value immediately before `i`.
	public func index(before i: Binding<Value>.Index) -> Binding<Value>.Index

	/// Replaces the given index with its predecessor.
	///  - Parameter i: A valid index of the collection. `i` must be greater than
	///   `startIndex`.
	public func formIndex(before i: inout Binding<Value>.Index)
}

extension Binding : RandomAccessCollection where Value : MutableCollection, Value : RandomAccessCollection, Value.Index : Hashable {
}

extension Binding {
	/// Creates an instance by projecting the base value to an optional value.
	public init<V>(_ base: Binding<V>) where Value == V?

	/// Creates an instance by projecting the base optional value to its
	/// unwrapped value, or returns `nil` if the base value is `nil`.
	public init?(_ base: Binding<Value?>)
	public init<V>(_ base: Binding<V>) where V : Hashable
}

extension Binding where Value : SetAlgebra, Value.Element : Hashable {
	/// Returns a `Binding<Bool>` representing whether `value` contains
	/// `element`.
	///  Setting the result to `true` will add `element` to `value`, and setting
	/// it to `false` will remove `element` from `value`.
	public func contains(_ element: Value.Element) -> Binding<Bool>
}

extension Binding where Value : RawRepresentable {
	/// Returns the projection of the receiver's value to its `rawValue`.
	public var rawValue: Binding<Value.RawValue> { get }
}

extension Binding where Value : CaseIterable, Value : Equatable {
	/// Projects the value of `self` to its index within `Value.allCases`.
	public var caseIndex: Binding<Value.AllCases.Index> { get }
}

/// Types that conform to BindingConvertible can provide a Binding to
/// their persistent storage.
@dynamicMemberLookup public protocol BindingConvertible {
	/// The type of the value represented by the binding.
	associatedtype Value

	/// A binding to the persistent storage of `self`.
	var binding: Binding<Self.Value> { get }

	/// Creates a new `Binding` focused on `Subject` using a key path.
	subscript<Subject>(dynamicMember keyPath: WritableKeyPath<Self.Value, Subject>) -> Binding<Subject> { get }
}

extension BindingConvertible {
	/// Creates a new `Binding` focused on `Subject` using a key path.
	public subscript<Subject>(dynamicMember keyPath: WritableKeyPath<Self.Value, Subject>) -> Binding<Subject> { get }
}

extension BindingConvertible {
	/// Create a new Binding that will apply `transaction` to any changes.
	public func transaction(_ transaction: Transaction) -> Binding<Self.Value>

	/// Create a new Binding that will apply `animation` to any changes.
	public func animation(_ animation: Animation? = .default) -> Binding<Self.Value>

	/// Creates a new `Binding` focused on `Subject` using a key path.
	public subscript<Subject>(keyPath: WritableKeyPath<Self.Value, Subject>) -> Binding<Subject> { get }

	/// Creates a new `Binding` focused on the wrapped value of the `Optional`
	/// `Subject` or the specified default value.
	public subscript<Subject>(keyPath: WritableKeyPath<Self.Value, Subject?>, default defaultValue: Subject) -> Binding<Subject> { get }

	/// Creates a new binding whose value is the pair of the values
	/// represented by the bindings `self` and `rhs`. Uses the
	/// transaction from `self` for the new binding.
	public func zip<T>(with rhs: T) -> Binding<(Self.Value, T.Value)> where T : BindingConvertible
}

public enum BlendMode {
	case normal
	case multiply
	case screen
	case overlay
	case darken
	case lighten
	case colorDodge
	case colorBurn
	case softLight
	case hardLight
	case difference
	case exclusion
	case hue
	case saturation
	case color
	case luminosity
	case clear
	case copy
	case sourceIn
	case sourceOut
	case sourceAtop
	case destinationOver
	case destinationIn
	case destinationOut
	case destinationAtop
	case exclusiveOr
	case plusDarker
	case plusLighter
}

/// A control that performs an action when triggered.
///
/// The method of "triggering" the button may vary. For example, on iOS a button
/// is triggered by tapping it onscreen, whereas on tvOS it's triggered by
/// pressing "select" on an external remote while the button is focused.
public struct Button<Label> where Label : View {
	/// Creates an instance.
	///  - Parameters:
	///     - action: The action to perform when `self` is triggered.
	///     - label: A view that describes the effect of calling `onTrigger`.
	public init(action: @escaping () -> Void, label: () -> Label)
	public var body: _View { get }

	public typealias Body
}

/// A capsule shape aligned inside the frame of the view containing it.
/// Equivalent to a rounded rectangle where the corner radius is chosen
/// as half the length of the rectangle's smallest edge.
public struct Capsule : Shape {
	public var style: RoundedCornerStyle

	@inlinable public init(style: RoundedCornerStyle = .circular)

	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in r: CGRect) -> Path

	/// The type defining the data to be animated.
	public typealias AnimatableData = EmptyAnimatableData

	public typealias Body = ShapeView<Capsule, ForegroundStyle>
}

extension Capsule : InsettableShape {
	/// Returns `self` inset by `amount`.
	@inlinable public func inset(by amount: Length) -> Capsule._Inset

	/// The type of the inset shape.
	public typealias InsetShape
}

/// A circle centered on the frame of the view containing it. The
/// radius is chosen as half the length of the rectangle's smallest
/// edge.
public struct Circle : Shape {
	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in rect: CGRect) -> Path

	@inlinable public init()

	/// The type defining the data to be animated.
	public typealias AnimatableData = EmptyAnimatableData

	public typealias Body = ShapeView<Circle, ForegroundStyle>
}

extension Circle : InsettableShape {
	/// Returns `self` inset by `amount`.
	@inlinable public func inset(by amount: Length) -> Circle._Inset

	/// The type of the inset shape.
	public typealias InsetShape
}

/// An environment-dependent color.
///
/// A `Color` is a late-binding token - its actual value is only resolved
/// when it is about to be used in a given environment. At that time it is
/// resolved to a concrete value.
public struct Color : Hashable, CustomStringConvertible {
}

extension Color {
	public typealias Body = Never
}

extension Color {
	public enum RGBColorSpace {
		case sRGB

		case sRGBLinear

		case displayP3

	}
	public init(_ colorSpace: Color.RGBColorSpace = .sRGB, red: Double, green: Double, blue: Double, opacity: Double = 1)
	public init(_ colorSpace: Color.RGBColorSpace = .sRGB, white: Double, opacity: Double = 1)
	public init(hue: Double, saturation: Double, brightness: Double, opacity: Double = 1)
}

extension Color {
}

extension Color : ShapeStyle {
}

extension Color {
	/// A set of colors that are used by system elements and applications.
	public static let clear: Color
	public static let black: Color
	public static let white: Color
	public static let gray: Color
	public static let red: Color
	public static let green: Color
	public static let blue: Color
	public static let orange: Color
	public static let yellow: Color
	public static let pink: Color
	public static let purple: Color
}

extension Color {
	/// A color that represents the accent color in the environment it is
	/// evaluated.
	///  If an explicit value hasn't been set, the default system accent color
	/// will be used.
		public static var accentColor: Color { get }
}

extension Color {
	public init(appearanceName: AppearanceColorName)
}

extension Color {
	/// Creates a named color.
	///  - Parameters:
	///   - name: the name of the color resource to lookup.
	///   - bundle: the bundle to search for the color resource in.
	public init(_ name: String, bundle: Bundle? = nil)
}

extension Color {
	public func opacity(_ opacity: Double) -> Color
}

extension Color : View {
}

/// Describes the working color space for color-compositing operations
/// and the range of color values that are guaranteed to be preserved.
public enum ColorRenderingMode {
	/// The non-linear sRGB (i.e. gamma corrected) working color space.
	/// Color component values outside the range [0, 1] have undefined
	/// results.
	case nonLinear

	/// The linear sRGB (i.e. not gamma corrected) working color space.
	/// Color component values outside the range [0, 1] have undefined
	/// results.
	case linear

	/// The linear sRGB (i.e. not gamma corrected) working color space.
	/// Color component values outside the range [0, 1] are preserved.
	case extendedLinear
}

/// The ColorScheme enumerates the user setting options for Light or Dark Mode
/// and also the light/dark setting for any particular view when the app
/// wants to override the user setting.
public enum ColorScheme {
	case light
	case dark
}

/// The ColorSchemeContrast enumerates the Increase Contrast user setting
/// options. The user's choice cannot be overridden by the app.
public enum ColorSchemeContrast {
	case standard
	case increased
}

/// A semantic type representing a command that can be requested to be performed
/// by a source that is disconnected from the responding target.
public struct Command : Hashable {
	/// Creates an instance using `selector` as its associated token.
	///  This is primarily useful for interoperability with AppKit and UIKit,
	/// where the `selector` can match that used by a source sender object.
	public init(_ selector: Selector)
	public static let delete: Command
	public static let cut: Command
	public static let copy: Command
}

/// View content that shows one of two possible children.
public struct ConditionalContent<TrueContent, FalseContent> where TrueContent : View, FalseContent : View {
	public typealias Body = Never
}

extension ConditionalContent : View {
}

public enum ContentMode {
	case fit
	case fill
}

public enum ContentSizeCategory : Equatable, Hashable {
	case extraSmall
	case small
	case medium
	case large
	case extraLarge
	case extraExtraLarge
	case extraExtraExtraLarge
	case accessibilityMedium
	case accessibilityLarge
	case accessibilityExtraLarge
	case accessibilityExtraExtraLarge
	case accessibilityExtraExtraExtraLarge
}

/// A container whose view content children will be presented as a menu items
/// in a contextual menu after completion of the standard system gesture.
///
/// The controls contained in a `ContextMenu` should be related to the context
/// they are being shown from.
///
/// - SeeAlso: `View.contextMenu`, which attaches a `ContextMenu` to a `View`.
public struct ContextMenu<MenuItems> where MenuItems : View {
	public init(menuItems: () -> MenuItems)
}

public enum ControlActiveState : Equatable {
	case key
	case active
	case inactive
}

public enum ControlSize {
	case regular
	case small
	case mini
}

public enum CoordinateSpace {
	case global
	case local
	case named(AnyHashable)
}

extension CoordinateSpace {
	public var isGlobal: Bool { get }
	public var isLocal: Bool { get }
}

extension CoordinateSpace : Equatable, Hashable {
}

/// A control for selecting an absolute `Date`.
///
/// It can be configured to only display specific components of the date, but
/// still results in picking a complete `Date` instance.
public struct DatePicker<Label> : View where Label : View {
	public typealias Components = DatePickerComponents

	/// Creates an instance that selects a `date` within the given range.
	///  - Parameters:
	///     - minimumDate: The oldest selectable date. A value of `nil`
	///         indicates there is no minimum. The default value is `nil`.
	///     - maximumDate: The most recent selectable date. A value of `nil`
	///         indicates there is no maximum. The default value is `nil`.
	///     - displayedComponents: The date components that user is able to
	///         view and edit. Defaults to `[.hourAndMinute, .date]`.
	///     - label: A view that describes the use of the date.
	public init(_ date: Binding<Date>, minimumDate: Date? = nil, maximumDate: Date? = nil, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date], label: () -> Label)
	public var body: AnyView { get }

	public typealias Body = AnyView
}

extension DatePicker where Label == EmptyView {
	/// Creates an instance that selects a `date` within the given range.
	///  - Parameters:
	///     - minimumDate: The oldest selectable date. A value of `nil`
	///         indicates there is no minimum. The default value is `nil`.
	///     - maximumDate: The most recent selectable date. A value of `nil`
	///         indicates there is no maximum. The default value is `nil`.
	///     - displayedComponents: The date components that user is able to
	///         view and edit. Defaults to `[.hourAndMinute, .date]`.
	public init(_ date: Binding<Date>, minimumDate: Date? = nil, maximumDate: Date? = nil, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date])
}

public struct DatePickerComponents : OptionSet {
	/// Displays hour and minute components based on the locale
	public static let hourAndMinute: DatePickerComponents

	/// Displays day, month, and year based on the locale
	public static let date: DatePickerComponents

	/// The element type of the option set.
	///  To inherit all the default implementations from the `OptionSet` protocol,
	/// the `Element` type must be `Self`, the default.
	public typealias Element = DatePickerComponents

	/// The type of the elements of an array literal.
	public typealias ArrayLiteralElement = DatePickerComponents

	public typealias RawValue = UInt
}

/// A specification for the appearance and interaction of a `DatePicker`.
public protocol DatePickerStyle {
	/// A view representing the appearance and interaction of a `DatePicker`.
	associatedtype Body : View

	/// Returns the appearance and interaction content for a `DatePicker`.
	func body(configuration: DatePicker<Self.Label>) -> Self.Body

	typealias Label = DatePickerStyleLabel
}

extension DatePickerStyle {
	public typealias Member = StaticMember<Self>
}

public struct DatePickerStyleLabel : View {
	public typealias Body = Never
}

public struct DefaultDatePickerStyle : DatePickerStyle {
	/// Returns the appearance and interaction content for a `DatePicker`.
	public func body(configuration: DatePicker<DefaultDatePickerStyle.Label>) -> DefaultDatePickerStyle.Body

	/// A view representing the appearance and interaction of a `DatePicker`.
	public struct Body {
		public var body: _View { get }
		public typealias Body
	}
}

/// The default `List` style.
public struct DefaultListStyle : ListStyle {
}

public struct DefaultToggleStyle : ToggleStyle {
	/// Returns the appearance and interaction content for a `Toggle`.
	///  All styles are expected to display the `content` of `toggle` in
	/// some way, visually indicate whether or not `toggle` is "on" or "off",
	/// and provide an interaction mechanism for toggling it.
	public func body(configuration: Toggle<DefaultToggleStyle.Label>) -> DefaultToggleStyle.Body

	/// A view representing the appearance and interaction of a `Toggle`.
	public struct Body {
		public var body: _View { get }
		public typealias Body
	}
}

/// A visual element that can be used to separate other content.
///
/// When contained in a stack, the divider extends across the minor axis
/// of the stack, or horizontally when not in a stack.
public struct Divider {
	public init()

	public typealias Body = Never
}

/// A gesture that invokes an action as a drag event sequence changes.
public struct DragGesture {
	/// The current state of the event sequence.
	public struct Value : Equatable {
		/// The time associated with the current event.
		public var time: Date

		/// The location of the current event.
		public var location: CGPoint

		/// The location of the first event.
		public var startLocation: CGPoint

		/// The total translation from the first event to the current
		/// event. Equivalent to `location.{x,y} -
		/// startLocation.{x,y}`.
		public var translation: CGSize { get }

		/// A prediction of where the final location would be if
		/// dragging stopped now, based on the current drag velocity.
		public var predictedEndLocation: CGPoint { get }

		/// A prediction of what the final translation would be if
		/// dragging stopped now, based on the current drag velocity.
		public var predictedEndTranslation: CGSize { get }

	}

	/// The distance that must be dragged before the gesture starts.
	public var minimumDistance: Length

	/// The coordinate space to receive location values in.
	public var coordinateSpace: CoordinateSpace
	public init(minimumDistance: Length = 10, coordinateSpace: CoordinateSpace = .local)

	public typealias Body = Never
}

extension DragGesture : Gesture {
}

/// A collection of functions that allow you to interact with a drop currently
/// occurring inside an onDrop modified view.
///
/// This collection is the most comprehensive and flexible way to interact
/// with a drop operation. For simple drop cases, see the `onDrop()` variants
/// that take a drop action instead of a `DropDelegate`.
///
/// - SeeAlso: `ViewModifier.onDrop(...)`
public protocol DropDelegate {
	/// Called when a drop, which has items conforming to any of the types
	/// passed to the onDrop() modifier, enters an onDrop target.
	///  The default implementation returns true.
	func validateDrop(info: DropInfo) -> Bool

	/// Tells the delegate it can request the item provider data from the
	/// DropInfo incorporating it into the application's data model as
	/// appropriate. This function is required.
	///  Return `true` if the drop was successful, `false` otherwise.
	func performDrop(info: DropInfo) -> Bool

	/// Tells the delegate a validated drop has entered the onDrop modified
	/// view. The default behavior does nothing.
	func dropEntered(info: DropInfo)

	/// Called as a validated drop moves inside the onDrop modified view.
	///  Return a drop proposal that contains the operation the delegate intends
	/// to perform at the DropInfo.location, The default implementation returns
	/// nil, which tells the drop to use that last valid returned value or else
	/// .copy.
	func dropUpdated(info: DropInfo) -> DropProposal?

	/// Tells the delegate a validated drop operation has exited the onDrop
	/// modified view. The default behavior does nothing.
	func dropExited(info: DropInfo)
}

extension DropDelegate {
	public func validateDrop(info: DropInfo) -> Bool
	public func dropEntered(info: DropInfo)
	public func dropUpdated(info: DropInfo) -> DropProposal?
	public func dropExited(info: DropInfo)
}

/// The description of the current state of a drop.
///
/// - SeeAlso `DropDelegate`
public struct DropInfo {
	/// The location of the drag in the coordinate space of the drop view.
	public var location: CGPoint { get }

	/// Returns whether at least one item conforms to at least one of the
	/// specified uniform type identifiers.
	public func hasItemsConforming(to types: [String]) -> Bool

	/// Returns an Array of items that each conform to at least one of the
	/// specified uniform type identifiers.
	///  This function is only valid during the performDrop() action.
	public func itemProviders(for types: [String]) -> [NSItemProvider]
}

/// Operation types that determine how a drag and drop session resolves when
/// the user drops a drag item.
public enum DropOperation {
	/// No data should be transferred, thereby canceling the drag.
	case cancel

	/// Although a move or copy operation is typically legitimate in this
	/// scenario, the drop activity is not allowed at this time or location.
	case forbidden

	/// The data represented by the drag items should be copied to the onDrop
	/// modified view.
	case copy

	/// The data represented by the drag items should be moved, not copied.
	case move
}

/// A configuration for the behavior of a drop.
public struct DropProposal {
	/// The drop operation that the drop proposes to perform.
	public let operation: DropOperation
	public init(operation: DropOperation)
}

/// A `DynamicViewProperty` representing a collection of possible destinations
/// in a navigation stack, generated from and identified by data provided at
/// presentation time.
public struct DynamicNavigationDestinationLink<Data, ID, Content> : DynamicViewProperty where ID : Hashable, Content : View {
	/// A `Binding` to the data representing the currently presented content.
	///  If `presentedData` is `nil`, then no presentation is possible; that is,
	/// `self` is declared on a view that is not contained within a
	/// `NavigationView`. If `presentedData.value` is `nil`, then presentation
	/// is possible, but nothing is currently presented.
	public var presentedData: Binding<Data?>? { get }

	/// Creates an instance representing a unique destination in a navigation
	/// stack that displays `content`.
	public init(id: KeyPath<Data, ID>, isDetail: Bool = true, content: @escaping (Data) -> Content?)
}

/// A type of `ViewContent2` that generates views from an underlying
/// collection of data.
public protocol DynamicViewContent : View {
	/// The type of the underlying collection of data.
	associatedtype Data : Collection

	/// The collection of underlying data.
	var data: Self.Data { get }
}

extension DynamicViewContent where Self.Data.Index : Hashable {
	/// Sets the deletion action to be used for `self`.
	///  - Parameter action: the action to be invoked when elements of the
	///     receiver are deleted.
	///     The closure receives a set of indices relative to the `Collection`
	///     driving the view content. Passing `nil` means the delete is disabled.
	public func onDelete(perform action: ((IndexSet) -> Void)?) -> Self.Modified<_TraitWritingModifier<((IndexSet) -> Void)?>>
}

extension DynamicViewContent {
	/// Sets the insert action to be used for `self`.
	///  - Parameters:
	///     - acceptedTypeIdentifiers: an array of UTI types that the receiver
	///         is able to accept.
	///     - action: a closure to be invoked when elements are insert in the
	///         receiver.
	///         The closure takes two argument, the first the index where to
	///         insert elements the second and array of `NSItemProvider` to
	///         retrieve data.
	public func onInsert(of acceptedTypeIdentifiers: [String], perform action: @escaping (Self.Data.Index, [NSItemProvider]) -> Void) -> Self.Modified<_TraitWritingModifier<OnInsertConfiguration?>>
}

extension DynamicViewContent {
	/// Sets the move action to be used for `self`.
	///  - Parameter action: the closure to be invoked when elements of the
	///     receiver are moved.
	///     The closure receives two arguments that are offsets
	///     relative to the `Collection` driving the view content.
	///     Passing `nil` means that move is disabled.
	public func onMove(perform action: ((IndexSet, Int) -> Void)?) -> Self.Modified<_TraitWritingModifier<((IndexSet, Int) -> Void)?>>
}

/// Represents a stored variable in a `View` type that is
/// "linked" to some external property of the view. These variables
/// will be given valid values immediately before `body()` is called.
public protocol DynamicViewProperty {
	/// Called immediately before the view's body() function is
	/// executed, after updating the values of any link variables
	/// stored in `self`.
	mutating func update()
}

extension DynamicViewProperty {
	public mutating func update()
}

/// Specifies one edge of a rectangle.
public enum Edge : Int8, CaseIterable {
	case top
	case leading
	case bottom
	case trailing

	/// An efficient set of `Edge`s.
	public struct Set : OptionSet {
		/// The element type of the option set.
		///
		/// To inherit all the default implementations from the `OptionSet` protocol,
		/// the `Element` type must be `Self`, the default.
		public typealias Element = Edge.Set

		public static let top: Edge.Set
		public static let leading: Edge.Set
		public static let bottom: Edge.Set
		public static let trailing: Edge.Set
		public static let all: Edge.Set
		public static let horizontal: Edge.Set
		public static let vertical: Edge.Set

		/// Creates an instance containing just `e`
		public init(_ e: Edge)

		/// The raw type that can be used to represent all values of the conforming
		/// type.
		///
		/// Every distinct value of the conforming type has a corresponding unique
		/// value of the `RawValue` type, but there may be values of the `RawValue`
		/// type that don't have a corresponding value of the conforming type.
		public typealias RawValue = Int8

		/// The type of the elements of an array literal.
		public typealias ArrayLiteralElement = Edge.Set.Element
	}

	public typealias RawValue = Int8

	/// A type that can represent a collection of all values of this type.
	public typealias AllCases = [Edge]
}

public struct EdgeInsets : Equatable {
	public var top: Length
	public var leading: Length
	public var bottom: Length
	public var trailing: Length
	public init(top: Length, leading: Length, bottom: Length, trailing: Length)
	public init()
}

extension EdgeInsets : Animatable {
	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<Length, AnimatablePair<Length, AnimatablePair<Length, Length>>>

	/// The data to be animated.
	public var animatableData: EdgeInsets.AnimatableData
}

/// An ellipse aligned inside the frame of the view containing it.
public struct Ellipse : Shape {
	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in rect: CGRect) -> Path

	@inlinable public init()

	/// The type defining the data to be animated.
	public typealias AnimatableData = EmptyAnimatableData

	public typealias Body = ShapeView<Ellipse, ForegroundStyle>
}

extension Ellipse : InsettableShape {
	/// Returns `self` inset by `amount`.
	@inlinable public func inset(by amount: Length) -> Ellipse._Inset

	/// The type of the inset shape.
	public typealias InsetShape
}

/// A type suitable for use as the `animatableData` property of types
/// that do not have any animatable properties.
public struct EmptyAnimatableData : VectorArithmetic {
	@inlinable public init()
}

/// The empty, or identity, modifier.
public struct EmptyModifier {
	public static let identity: EmptyModifier

	@inlinable public init()

	/// Returns the current body of `self`. `content` is a proxy for
	/// the view that will have the modifier represented by `Self`
	/// applied to it.
	public func body(content: EmptyModifier.Content) -> Never

	/// The type of view representing the body of `Self`.
	public typealias Body = Never
}

extension EmptyModifier : ViewModifier {
}

public struct EmptyView {
	@inlinable public init()

	public typealias Body = Never
}

extension EmptyView : View {
}

/// A linked View property that reads a value from the view's
/// environment.
@propertyDelegate public struct Environment<Value> : DynamicViewProperty {
	/// Initializes to read the environment property `keyPath`.
	@inlinable public init(_ keyPath: KeyPath<EnvironmentValues, Value>)

	/// The current value of the environment property.
	@inlinable public var value: Value { get }
}

public protocol EnvironmentKey {
	associatedtype Value

	static var defaultValue: Self.Value { get }
}

/// A linked View property that reads a `BindableObject` supplied by an ancestor
/// view that will automatically invalidate its view when the object changes.
///
/// - Precondition: A model must be provided on an ancestor view by calling
///     `store(model:)`.
@propertyDelegate @dynamicMemberLookup public struct EnvironmentObject<BindableObjectType> : DynamicViewProperty where BindableObjectType : BindableObject {
	/// The current model supplied by an ancestor view.
	@inlinable public var value: BindableObjectType { get }
	public var delegateValue: ObjectBinding<BindableObjectType>.Wrapper { get }
	public var storageValue: ObjectBinding<BindableObjectType>.Wrapper { get }
	public init()

	/// Creates a new `Binding` focused on `Subject` using a key path.
	public subscript<Subject>(dynamicMember keyPath: ReferenceWritableKeyPath<BindableObjectType, Subject>) -> Binding<Subject> { get }
}

/// A collection of environment values.
public struct EnvironmentValues : CustomStringConvertible {
	public init()
	public subscript<K>(key: K.Type) -> K.Value where K : EnvironmentKey
}

extension EnvironmentValues {
	public var sizeCategory: ContentSizeCategory
}

extension EnvironmentValues {
	public var layoutDirection: LayoutDirection
}

extension EnvironmentValues {
	/// The current undo manager that views should use to register undo
	/// operations.
	///  The `UndoManager` is `nil`, the environemnt represents a context
	/// where undo/redo is not supported, and registrations can be skipped.
	public var undoManager: UndoManager? { get }
}

extension EnvironmentValues {
	/// Whether the view with this environment can be interacted with.
	///  The default value is true.
	public var isEnabled: Bool
}

extension EnvironmentValues {
	/// The default font of this environment.
	public var font: Font?

	/// The display scale of this environment.
	public var displayScale: Length

	/// The size of a pixel on the screen. Equal to 1 / displayScale.
	public var pixelLength: Length { get }

	/// The current locale that views should use.
	public var locale: Locale

	/// The current calendar that views should use when handling dates.
	public var calendar: Calendar

	/// The current time zone that views should use when handling dates.
	public var timeZone: TimeZone

	/// The color scheme of this environment.
	///  If you're writing custom drawing code that depends on the current color
	/// scheme, you should also consider the `colorSchemeContrast` property.
	/// You can specify images and colors in asset catalogs
	/// according to either the `light` or `dark` color scheme, as well as
	/// standard or increased contrast. The correct image or color displays
	/// automatically for the current environment.
	///  You only need to check `colorScheme` and `colorSchemeContrast` for
	/// custom drawing if the differences go beyond images and colors.
	public var colorScheme: ColorScheme

	/// The contrast associated with the color scheme of this environment.
	public var colorSchemeContrast: ColorSchemeContrast { get }
}

extension EnvironmentValues {
	public var controlActiveState: ControlActiveState
}

extension EnvironmentValues {
}

extension EnvironmentValues {
	public var controlSize: ControlSize
}

extension EnvironmentValues {
	/// How `Text` will align its lines with respect to one another when the
	/// content wraps, or contains newlines.
	///  - Note: because the horizontal bounds of `Text` never exceed its
	///   graphical extent, this property has almost no effect on single-line
	///   `Text`.  Use alignment parameters on a parent view to align `Text`
	///   with respect to its parent.
	public var multilineTextAlignment: HAlignment

	/// How the last line of text is truncated to fit into the available space.
	///  The default is `.tail`.
	public var truncationMode: Text.TruncationMode
	public var lineSpacing: Length

	/// Whether inter-character spacing should tighten, in order to fit the text
	/// into the available space.
	///  The default is `false`.
	public var allowsTightening: Bool

	/// A limit on the number of lines used to render text in the available
	/// space.
	///  If `nil`, the text uses as many lines as required.
	///  The default is `1`.
	public var lineLimit: Int?

	/// The minimum permissible proportion to shrink the font size, in order to
	/// fit the text into the available space.
	///  For example, a label with a `minimumScaleFactor` of `0.5` will draw its
	/// text in a font size as small as half of the actual font if needed.
	///  The default is `1.0`.
	///  - Precondition: 0.0 < `minimumScaleFactor` <= 1.0
	public var minimumScaleFactor: Length
}

extension EnvironmentValues {
	/// If an assistive technology is enabled
	public var accessibilityEnabled: Bool
}

extension EnvironmentValues {
	/// The default minimum height of a row in a `List`.
	public var defaultMinListRowHeight: Length

	/// The minimum height of a header in a `List`.
	///  The default value is `nil`, which means the system will choose the
	/// appropriate value automatically.
	public var defaultMinListHeaderHeight: Length?
}

extension EnvironmentValues {
	/// A `Binding` to whether `self` is part of a hierarchy that is currently
	/// being presented.
	public var isPresented: Binding<Bool>?
}

/// A modifier that needs to be resolved in an environment before it can be used.
public protocol EnvironmentalModifier : ViewModifier where Self.Body == Never {
	/// The type of modifier to use after being resolved.
	associatedtype ResolvedModifier : ViewModifier

	/// Resolve to a concrete modifier in the given `environment`.
	func resolve(in environment: EnvironmentValues) -> Self.ResolvedModifier
}

/// A view type that compares itself against its previous value and
/// prevents its child updating if its new value is the same as its old
/// value.
public struct EquatableView<Content> where Content : Equatable, Content : View {
	public var content: Content

	@inlinable public init(content: Content)

	public typealias Body = Never
}

public struct EventModifiers : OptionSet {
	public static let capsLock: EventModifiers
	public static let shift: EventModifiers
	public static let control: EventModifiers
	public static let option: EventModifiers
	public static let command: EventModifiers
	public static let numericPad: EventModifiers
	public static let function: EventModifiers
	public static let all: EventModifiers

	public typealias RawValue = Int

	/// The element type of the option set.
	///  To inherit all the default implementations from the `OptionSet` protocol,
	/// the `Element` type must be `Self`, the default.
	public typealias Element = EventModifiers

	/// The type of the elements of an array literal.
	public typealias ArrayLiteralElement = EventModifiers
}

/// A pair of gestures where only can succeed, giving precedence to
/// the first of the pair.
public struct ExclusiveGesture<First, Second> where First : Gesture, Second : Gesture {
	/// The type of value produced by this gesture.
	public enum Value {
		/// The first gesture's value.
		case first(First.Value)

		/// The second gesture's value.
		case second(Second.Value)
	}
	public var first: First
	public var second: Second

	/// Creates an instance from two child gestures.
	@inlinable public init(_ first: First, _ second: Second)

	public typealias Body = Never
}

extension ExclusiveGesture : Gesture {
}

extension ExclusiveGesture.Value : Equatable where First.Value : Equatable, Second.Value : Equatable {
}

public struct FieldDatePickerStyle : DatePickerStyle {
	/// Returns the appearance and interaction content for a `DatePicker`.
	public func body(configuration: DatePicker<FieldDatePickerStyle.Label>) -> FieldDatePickerStyle.Body

	/// A view representing the appearance and interaction of a `DatePicker`.
	public struct Body {
		public var body: _View { get }
		public typealias Body
	}
}

/// A style for rasterizing vector shapes.
public struct FillStyle : Equatable {
	/// A Boolean value that indicates whether to use the even-odd rule when
	/// rendering a shape.
	///  When `isOEFilled` is `false`, the style uses the non-zero winding
	/// number rule.
	public var isEOFilled: Bool

	/// A Boolean value that indicates whether to apply antialiasing the edges
	/// of a shape.
	public var isAntialiased: Bool

	/// Creates a new style with the specified settings.
	///  - Parameters:
	///   - eoFill: A Boolean value that indicates whether to use the even-od
	///     rule for rendering a shape. Pass `false` to use the non-zero
	///     winding number rule instead.
	///   - antialiased: A Boolean value that indicates whether to use
	///     antialiasing when rendering the edges of a shape.
	public init(eoFill: Bool = false, antialiased: Bool = true)
}

/// An environment-dependent font.
///
/// A `Font` is a late-binding token - its actual value is only resolved
/// when it is about to be used in a given environment. At that time it is
/// resolved to a concrete value.
public struct Font : Hashable {
}

extension Font {
	/// Create a font with the large title text style.
	public static let largeTitle: Font

	/// Create a font with the title text style.
	public static let title: Font

	/// Create a font with the headline text style.
	public static var headline: Font

	/// Create a font with the subheadline text style.
	public static var subheadline: Font

	/// Create a font with the body text style.
	public static var body: Font

	/// Create a font with the callout text style.
	public static var callout: Font

	/// Create a font with the footnote text style.
	public static var footnote: Font

	/// Create a font with the caption text style.
	public static var caption: Font

	/// Create a system font with the given `style`.
	public static func system(_ style: Font.TextStyle, design: Font.Design = .default) -> Font

	/// Create a system font with the given `size`.
	public static func system(size: Length, design: Font.Design = .default) -> Font

	/// Create a custom font with the given `name` and `size`.
	public static func custom(_ name: String, size: Length) -> Font

	/// A dynamic text style to use for fonts.
	public enum TextStyle {
		case largeTitle

		case title

		case headline

		case subheadline

		case body

		case callout

		case footnote

		case caption

	}

	/// A design to use for fonts.
	public enum Design : Hashable {
		case `default`

		case serif

		case rounded

		case monospaced

	}
}

extension Font {
	/// Create a version of `self` that is italic.
	public func italic() -> Font

	/// Create a version of `self` that uses small capitals.
	public func smallCaps() -> Font

	/// Create a version of `self` that uses monospace digits.
	public func monospacedDigit() -> Font

	/// Create a version of `self` that has the specified `weight`.
	public func weight(_ weight: Font.Weight) -> Font

	/// Create a version of `self` that is bold.
	public func bold() -> Font

	/// A weight to use for fonts.
	public struct Weight : Hashable {
		public static let ultraLight: Font.Weight

		public static let thin: Font.Weight

		public static let light: Font.Weight

		public static let regular: Font.Weight

		public static let medium: Font.Weight

		public static let semibold: Font.Weight

		public static let bold: Font.Weight

		public static let heavy: Font.Weight

		public static let black: Font.Weight

	}
}

/// A structure that computes views on demand from an underlying collection of
/// of identified data.
public struct ForEach<Data, Content> where Data : RandomAccessCollection, Content : View, Data.Element : Identifiable {
	/// The collection of underlying identified data.
	public var data: Data

	/// A function that can be used to generate content on demand given
	/// underlying data.
	public var content: (Data.Element.IdentifiedValue) -> Content

	/// Creates an instance that uniquely identifies views across updates based
	/// on the identity of the underlying data element.
	///  It's important that the id of a data element does not change
	/// unless the data element is considered to have been replaced with a new
	/// data element with a new identity. If the id of a data element
	/// changes, then the content view generated from that data element will
	/// lose any current state and animations.
	public init(_ data: Data, content: @escaping (Data.Element.IdentifiedValue) -> Content)

	public typealias Body = Never
}

extension ForEach : DynamicViewContent {
}

public struct ForegroundStyle {
	@inlinable public init()
}

extension ForegroundStyle : ShapeStyle {
}

/// Changes the visual appearance of a view without changing its
/// ancestors or descendents, other than changing the coordinate
/// transform to and from them.
public protocol GeometryEffect : Animatable, _MultiViewModifier where Self.Body == Never {
	/// The current value of the effect.
	func effectValue(size: CGSize) -> ProjectionTransform
}

extension GeometryEffect {
	/// Returns an effect producing the same geometry transform as
	/// `self` but that will only be applied while rendering its view,
	/// not while the view is performing its layout calculations. This
	/// is often used to disable layout changes during transitions.
	@inlinable public func ignoredByLayout() -> _IgnoredByLayoutEffect<Self>
}

extension GeometryEffect {
}

/// Acts as a proxy for access to the size and coordinate space (for
/// anchor resolution) of the container view.
public struct GeometryProxy {
	/// The size of the container view.
	public var size: CGSize { get }

	/// Resolves the value of `anchor` to the container view.
	public subscript<T>(anchor: Anchor<T>) -> T where T : Equatable { get }

	/// The safe area inset of the container view.
	public var safeAreaInsets: EdgeInsets { get }

	/// The container view's bounds rectangle converted to a defined
	/// coordinate space.
	public func frame(in coordinateSpace: CoordinateSpace) -> CGRect
}

/// A container view that defines its content as a function of its own
/// size and coordinate space. Returns a flexible preferred size to its
/// parent layout.
public struct GeometryReader<Content> where Content : View {
	public var content: (GeometryProxy) -> Content

	@inlinable public init(content: @escaping (GeometryProxy) -> Content)

	public typealias Body = Never
}

/// An input gesture, a value that matches a sequence of events and
/// returns a stream of values.
public protocol Gesture {
	/// The type of value produced by this gesture.
	associatedtype Value

	associatedtype Body : Gesture

	/// Returns the current body of `self`.
	var body: Self.Body { get }
}

extension Gesture {
	/// Returns a new gesture that is the same as `self` except that it only
	/// matches events as long as the modifier keys corresponding to the given
	/// modifiers option set are held down.
	///  - Parameters:
	///     - modifiers: A set of flags corresponding to the modifier keys that
	///       must be down in order for the gesture to succeed.
	/// - Returns: A new gesture.
	public func modifiers(_ modifiers: EventModifiers) -> _ModifiersGesture<Self>
}

extension Gesture {
	/// Adds an action to perform when the gesture ends.
	///  - Parameter action: The action to perform when this gesture ends. The
	///   `action` closure's parameter contains the final value of the
	///    gesture.
	/// - Returns: A gesture that triggers `action` when the gesture ends.
	public func onEnded(_ action: @escaping (Self.Value) -> Void) -> _EndedGesture<Self>
}

extension Gesture where Self.Value : Equatable {
	/// Adds an action to perform when the gesture's value changes.
	///  - Parameter action: The action to perform when this gesture's value
	///   changes. The `action` closure's parameter contains the gesture's new
	///   value.
	/// - Returns: A gesture that triggers `action` when this gesture's value
	///   changes.
	public func onChanged(_ action: @escaping (Self.Value) -> Void) -> _ChangedGesture<Self>
}

extension Gesture {
	@inlinable public func simultaneously<Other>(with other: Other) -> SimultaneousGesture<Self, Other> where Other : Gesture
}

extension Gesture {
	public func map<T>(_ body: @escaping (Self.Value) -> T) -> _MapGesture<Self, T>
}

extension Gesture {
	@inlinable public func exclusively<Other>(before other: Other) -> ExclusiveGesture<Self, Other> where Other : Gesture
}

extension Gesture {
	/// Returns a new gesture that will sequence `self` and `other`,
	/// such that `other` does not receive any events until `self` has
	/// succeeded.
	@inlinable public func sequenced<Other>(before other: Other) -> SequenceGesture<Self, Other> where Other : Gesture
}

extension Gesture {
	/// Returns a new version of the gesture that will use the `body`
	/// function to update `state` as the gesture's value changes,
	/// resetting `state` to its initial value when the gesture becomes
	/// inactive.
	public func updating<StateType>(_ state: GestureState<StateType>, body: @escaping (Self.Value, inout StateType, inout Transaction) -> Void) -> AnyGesture<Self.Value>
}

public struct GestureMask : OptionSet {
	public static let none: GestureMask
	public static let gesture: GestureMask
	public static let subviews: GestureMask
	public static let all: GestureMask

	/// The element type of the option set.
	///  To inherit all the default implementations from the `OptionSet` protocol,
	/// the `Element` type must be `Self`, the default.
	public typealias Element = GestureMask

	/// The type of the elements of an array literal.
	public typealias ArrayLiteralElement = GestureMask

	public typealias RawValue = UInt32
}

/// Link type to store gesture state that is updated as a gesture
/// changes and implicitly reset when the gesture becomes inactive.
@propertyDelegate public struct GestureState<Value> : DynamicViewProperty {
	/// Initialize with the initial state value.
	public init(initialValue: Value)

	/// Initialize with the initial state value, and the transaction
	/// used to reset the state back to the initial value when its
	/// associated gesture becomes inactive.
	public init(initialValue: Value, resetTransaction: Transaction)

	/// The current value of the state.
	public var value: Value { get }
}

extension GestureState where Value : ExpressibleByNilLiteral {
	public init(resetTransaction: Transaction = Transaction())
}

/// A color gradient. Represented as an array of color stops, each
/// color having a parametric location value.
public struct Gradient : Equatable {
	/// One color stop in the gradient.
	public struct Stop : Equatable {
		/// The color for the stop.
		public var color: Color

		/// The parametric location of the stop, must be in the range
		/// [0, 1] or results are undefined.
		public var location: CGFloat

		/// Initialize with a color and location.
		public init(color: Color, location: CGFloat)

	}

	/// The array of color stops.
	public var stops: [Gradient.Stop]

	/// Initialize with an array of color stops.
	public init(stops: [Gradient.Stop])

	/// Initialize with an array of colors, location values will be
	/// synthesized to evenly space the colors along the gradient.
	public init(colors: [Color])
}

public struct GraphicalDatePickerStyle : DatePickerStyle {
	/// Returns the appearance and interaction content for a `DatePicker`.
	public func body(configuration: DatePicker<GraphicalDatePickerStyle.Label>) -> GraphicalDatePickerStyle.Body

	/// A view representing the appearance and interaction of a `DatePicker`.
	public struct Body {
		public var body: _View { get }
		public typealias Body
	}
}

/// An affordance for grouping view content.
public struct Group<Content> where Content : View {
	public init(content: () -> Content)

	public typealias Body = Never
}

/// A stylized view with an optional label that is associated with a logical
/// grouping of content.
public struct GroupBox<Label, Content> where Label : View, Content : View {
	public init(label: Label, content: () -> Content)
	public var body: _View { get }

	public typealias Body
}

extension GroupBox where Label == EmptyView {
	public init(content: () -> Content)
}

/// Aligns the child view within its bounds given anchor types
///
/// Child sizing: Respects the child's preferred size on the aligned axes. The child fills the context bounds on unaligned axes.
///
/// Preferred size: Child's preferred size
/// An alignment in the horizontal axis.
public enum HAlignment {
	case leading
	case center
	case trailing
}

/// A layout container that arranges its children in a horizontal line
/// and allows the user to resize them using dividers placed between them.
public struct HSplitView<Content> where Content : View {
	public init(content: () -> Content)

	public typealias Body = Never
}

/// A view that arranges its children in a vertical line.
public struct HStack<Content> where Content : View {
	/// Creates an instance with the given `spacing` and Y axis `alignment`.
	///  - Parameters:
	///     - alignment: the guide that will have the same horizontal screen
	///       coordinate for all children.
	///     - spacing: the distance between adjacent children, or nil if the
	///       stack should choose a default distance for each pair of children.
	@inlinable public init(alignment: VerticalAlignment = .center, spacing: Length? = nil, content: () -> Content)

	public typealias Body = Never
}

/// An alignment position along the horizontal axis
public struct HorizontalAlignment {
	/// Creates an instance with the given ID.
	///  Note: each instance should have a unique ID.
	public init(_ id: AlignmentID.Type)
}

extension HorizontalAlignment {
	/// A guide marking the leading edge of the view.
	public static let leading: HorizontalAlignment

	/// A guide marking the horizontal center of the view.
	public static let center: HorizontalAlignment

	/// A guide marking the trailing edge of the view.
	public static let trailing: HorizontalAlignment
}

extension HorizontalAlignment : Equatable {
}

/// A uniquely identified view that can be inserted or removed.
public struct IDView<Content, ID> where Content : View, ID : Hashable {
	public var content: Content
	public var id: ID

	@inlinable public init(_ content: Content, id: ID)

	public typealias Body = Never
}

extension IDView : View {
}

/// A type that can be compared for identity equality.
public protocol Identifiable {
	/// A type of unique identifier that can be compared for equality.
	associatedtype ID : Hashable

	/// A unique identifier that can be compared for equality.
	var id: Self.ID { get }

	/// The type of value identified by `id`.
	associatedtype IdentifiedValue = Self

	/// The value identified by `id`.
	///  By default this returns `self`.
	var identifiedValue: Self.IdentifiedValue { get }
}

extension Identifiable where Self == Self.IdentifiedValue {
	public var identifiedValue: Self { get }
}

extension Identifiable where Self : AnyObject {
	public var id: ObjectIdentifier { get }
}

/// An identifier and value that is uniquely identified by it.
public struct IdentifierValuePair<ID, Value> : Identifiable where ID : Hashable {
	/// A unique identifier that can be compared for equality.
	public let id: ID

	/// A value identified by `id`.
	public let value: Value

	/// Creates an instance.
	public init(id: ID, value: Value)

	/// The value identified by `id`.
	///  By default this returns `self`.
	public var identifiedValue: Value { get }

	/// The type of value identified by `id`.
	public typealias IdentifiedValue = Value
}

/// A collection of identifier-value pairs computed on demand by calling
/// `getID`.
public struct IdentifierValuePairs<Base, ID> : Collection where Base : Collection, ID : Hashable {
	/// A type that represents a position in the collection.
	///  Valid indices consist of the position of every element and a
	/// "past the end" position that's not valid for use as a subscript
	/// argument.
	public typealias Index = Base.Index

	/// A type representing the sequence's elements.
	public typealias Element = IdentifierValuePair<ID, Base.Element>

	/// The position of the first element in a nonempty collection.
	///  If the collection is empty, `startIndex` is equal to `endIndex`.
	public var startIndex: Base.Index { get }

	/// The collection's "past the end" position---that is, the position one
	/// greater than the last valid subscript argument.
	///  When you need a range that includes the last element of a collection, use
	/// the half-open range operator (`..<`) with `endIndex`. The `..<` operator
	/// creates a range that doesn't include the upper bound, so it's always
	/// safe to use with `endIndex`. For example:
	/// 	let numbers = [10, 20, 30, 40, 50]
	///     if let index = numbers.firstIndex(of: 30) {
	///         print(numbers[index ..< numbers.endIndex])
	///     }
	///     // Prints "[30, 40, 50]"
	///  If the collection is empty, `endIndex` is equal to `startIndex`.
	public var endIndex: Base.Index { get }

	/// Returns the position immediately after the given index.
	///  The successor of an index must be well defined. For an index `i` into a
	/// collection `c`, calling `c.index(after: i)` returns the same index every
	/// time.
	///  - Parameter i: A valid index of the collection. `i` must be less than
	///   `endIndex`.
	/// - Returns: The index value immediately after `i`.
	public func index(after i: IdentifierValuePairs<Base, ID>.Index) -> IdentifierValuePairs<Base, ID>.Index

	/// Replaces the given index with its successor.
	///  - Parameter i: A valid index of the collection. `i` must be less than
	///   `endIndex`.
	public func formIndex(after i: inout IdentifierValuePairs<Base, ID>.Index)

	/// Accesses the element at the specified position.
	///  The following example accesses an element of an array through its
	/// subscript to print its value:
	/// 	var streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
	///     print(streets[1])
	///     // Prints "Bryant"
	///  You can subscript a collection with any valid index other than the
	/// collection's end index. The end index refers to the position one past
	/// the last element of a collection, so it doesn't correspond with an
	/// element.
	///  - Parameter position: The position of the element to access. `position`
	///   must be a valid index of the collection that is not equal to the
	///   `endIndex` property.
	///  - Complexity: O(1)
	public subscript(position: IdentifierValuePairs<Base, ID>.Index) -> IdentifierValuePairs<Base, ID>.Element { get }

	/// A type that provides the collection's iteration interface and
	/// encapsulates its iteration state.
	///  By default, a collection conforms to the `Sequence` protocol by
	/// supplying `IndexingIterator` as its associated `Iterator`
	/// type.
	public typealias Iterator = IndexingIterator<IdentifierValuePairs<Base, ID>>
}

extension IdentifierValuePairs : BidirectionalCollection where Base : BidirectionalCollection {
	/// Returns the position immediately before the given index.
	///  - Parameter i: A valid index of the collection. `i` must be greater than
	///   `startIndex`.
	/// - Returns: The index value immediately before `i`.
	public func index(before i: IdentifierValuePairs<Base, ID>.Index) -> IdentifierValuePairs<Base, ID>.Index

	/// Replaces the given index with its predecessor.
	///  - Parameter i: A valid index of the collection. `i` must be greater than
	///   `startIndex`.
	public func formIndex(before i: inout IdentifierValuePairs<Base, ID>.Index)
}

extension IdentifierValuePairs : RandomAccessCollection where Base : RandomAccessCollection {
	/// A sequence that represents a contiguous subrange of the collection's
	/// elements.
	///  This associated type appears as a requirement in the `Sequence`
	/// protocol, but it is restated here with stricter constraints. In a
	/// collection, the subsequence should also conform to `Collection`.
	public typealias SubSequence = Slice<IdentifierValuePairs<Base, ID>>

	/// A type that represents the indices that are valid for subscripting the
	/// collection, in ascending order.
	public typealias Indices = DefaultIndices<IdentifierValuePairs<Base, ID>>
}

/// An environment-dependent image.
///
/// An `Image` is a late-binding token - its actual value is only resolved
/// when it is about to be used in a given environment. At that time it is
/// resolved to a concrete value.
public struct Image : Equatable {
}

extension Image {
	/// Creates a labeled image usable as content for controls.
	///  - Parameters:
	///     - name: the name of the image resource to lookup, as well as
	///       the localization key with which to label the image.
	///     - bundle: the bundle to search for the image resource and
	///       localization content. If `nil`, uses the main `Bundle`.
	///       Defaults to `nil`.
	public init(_ name: String, bundle: Bundle? = nil)

	/// Creates a labeled image usable as content for controls, with an custom
	/// specified label.
	///  - Parameters:
	///     - name: the name of the image resource to lookup
	///     - bundle: the bundle to search for the image resource.
	///       If `nil`, uses the main `Bundle`. Defaults to `nil`.
	///     - label: The label associated with the image. The label is used for
	///       things like accessibility.
	public init(_ name: String, bundle: Bundle? = nil, label: Text)

	/// Creates an unlabeled, decorative image.
	///  - Parameters:
	///   - name: the name of the image resource to lookup
	///   - bundle: the bundle to search for the image resource. If `nil`, uses
	///     the main `Bundle`. Defaults to `nil`.
	///  This image will be specifically ignored for accessibility purposes.
	public init(decorative name: String, bundle: Bundle? = nil)
}

extension Image {
	public func renderingMode(_ renderingMode: Image.TemplateRenderingMode?) -> Image
}

extension Image {
	public init(nsImage: NSImage)
}

extension Image {
	public typealias Body = Never
}

extension Image {
	public enum TemplateRenderingMode {
		case template

		case original

	}
}

extension Image {
	public enum Interpolation {
		case none

		case low

		case medium

		case high

	}
}

extension Image {
	public func interpolation(_ interpolation: Image.Interpolation) -> Image
	public func antialiased(_ isAntialiased: Bool) -> Image
}

extension Image {
	public enum ResizingMode {
		case tile

		case stretch

	}
	public func resizable(capInsets: EdgeInsets = EdgeInsets(), resizingMode: Image.ResizingMode = .stretch) -> Image
}

extension Image {
	/// Creates a labeled image based on a `CGImage`, usable as content for
	/// controls.
	///  - Parameters:
	///   - cgImage: the base graphical image
	///   - scale: the scale factor the image is intended for
	///     (e.g. 1.0, 2.0, 3.0)
	///   - label: The label associated with the image. The label is used for
	///     things like accessibility.
	public init(_ cgImage: CGImage, scale: Length, label: Text)

	/// Creates an unlabeled, decorative image based on a `CGImage`.
	///  - Parameters:
	///   - cgImage: the base graphical image
	///   - scale: the scale factor the image is intended for
	///     (e.g. 1.0, 2.0, 3.0)
	///  This image will be specifically ignored for accessibility purposes.
	public init(decorative cgImage: CGImage, scale: Length)
}

extension Image : View {
}

/// Paint type that repeats an image over the infinite plane.
public struct ImagePaint {
	/// The image to be drawn.
	public var image: Image

	/// A unit-space rectangle defining how much of the source image
	/// to draw.
	public var sourceRect: CGRect

	/// A scale factor applied to the image while being drawn.
	public var scale: Length
	public init(image: Image, sourceRect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1), scale: Length = 1)
}

extension ImagePaint : ShapeStyle {
}

/// A shape type that is able to inset itself to produce another shape.
public protocol InsettableShape : Shape {
	/// The type of the inset shape.
	associatedtype InsetShape : Shape

	/// Returns `self` inset by `amount`.
	func inset(by amount: Length) -> Self.InsetShape
}

extension InsettableShape {
	/// Returns a view that is the result of insetting `self` by
	/// `style.lineWidth / 2`, stroking the resulting shape with
	/// `style`, and then filling with `content`.
	@inlinable public func strokeBorder<S>(_ content: S, style: StrokeStyle, antialiased: Bool = true) -> Self.InsetShape.Stroked.Filled<S> where S : ShapeStyle

	/// Returns a view that is the result of insetting `self` by
	/// `style.lineWidth / 2`, stroking the resulting shape with
	/// `style`, and then filling with the foreground color.
	@inlinable public func strokeBorder(style: StrokeStyle, antialiased: Bool = true) -> Self.InsetShape.Stroked.Filled<ForegroundStyle>

	/// Returns a view that is the result of filling the `width`-sized
	/// border (aka inner stroke) of `self` with `content`. This is
	/// equivalent to insetting `self` by `width / 2` and stroking the
	/// resulting shape with `width` as the line-width.
	@inlinable public func strokeBorder<S>(_ content: S, lineWidth: Length = 1, antialiased: Bool = true) -> Self.InsetShape.Stroked.Filled<S> where S : ShapeStyle

	/// Returns a view that is the result of filling the `width`-sized
	/// border (aka inner stroke) of `self` with the foreground color.
	/// This is equivalent to insetting `self` by `width / 2` and
	/// stroking the resulting shape with `width` as the line-width.
	@inlinable public func strokeBorder(lineWidth: Length = 1, antialiased: Bool = true) -> Self.InsetShape.Stroked.Filled<ForegroundStyle>
}

public struct ItemBasedPopUpButton<T> where T : Equatable {
	public enum Item {
		case titled(label: String, value: T)

		case titledWithImage(label: String, image: Image, value: T)

		case divider
	}
	public init(value: Binding<T>, items: [ItemBasedPopUpButton<T>.Item])
	public init(value: Binding<T?>, items: [ItemBasedPopUpButton<T>.Item])
	public var body: _View { get }

	public typealias Body
}

public enum LayoutDirection : Equatable, Hashable {
	case leftToRight
	case rightToLeft
}

/// The floating-point type used for all scalar geometry values.
public typealias Length = CGFloat

/// A linear gradient. The gradient's color function is applied along
/// an axis, where the axis is defined by a start and end points. The
/// unit-space points are mapped into the bounding rectangle of each
/// shape filled with the gradient.
public struct LinearGradient : ShapeStyle {
	public init(gradient: Gradient, startPoint: UnitPoint, endPoint: UnitPoint)
}

/// A container that presents rows of data arranged in a single column.
public struct List<Selection, Content> where Selection : SelectionManager, Content : View {
	/// Creates an instance.
	///  - Parameter selection: A selection manager that identifies the selected row(s).
	///  - See Also: `View.selectionValue` which gives an identifier to the rows.
	///  - Note: On iOS and tvOS, you must explicitly put the `List` into Edit
	/// Mode for the selection to apply.
		public init(selection: Binding<Selection>?, content: () -> Content)

	public typealias Body = Never
}

extension List {
	/// Creates a List that computes its rows on demand from an underlying
	/// collection of identified data.
		public init<Data, RowContent>(_ data: Data, selection: Binding<Selection>?, rowContent: @escaping (Data.Element.IdentifiedValue) -> RowContent) where Content == ForEach<Data, HStack<RowContent>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable

	/// Creates a List that computes its rows on demand from an underlying
	/// collection of identified data.
		public init<Data, RowContent>(_ data: Data, selection: Binding<Selection>?, action: @escaping (Data.Element.IdentifiedValue) -> Void, rowContent: @escaping (Data.Element.IdentifiedValue) -> RowContent) where Content == ForEach<Data, Button<HStack<RowContent>>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable
}

extension List where Selection == Never {
	public init(content: () -> Content)

	/// Creates a List that computes its rows on demand from an underlying
	/// collection of identified data.
	public init<Data, RowContent>(_ data: Data, rowContent: @escaping (Data.Element.IdentifiedValue) -> RowContent) where Content == ForEach<Data, HStack<RowContent>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable

	/// Creates a List that computes its rows on demand from an underlying
	/// collection of identified data.
	public init<Data, RowContent>(_ data: Data, action: @escaping (Data.Element.IdentifiedValue) -> Void, rowContent: @escaping (Data.Element.IdentifiedValue) -> RowContent) where Content == ForEach<Data, Button<HStack<RowContent>>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable
}

/// A specification for the appearance and interaction of a `List`.
public protocol ListStyle {
}

extension ListStyle {
	public typealias Member = StaticMember<Self>
}

/// The key used to looked up in a .string or .stringdict file.
public struct LocalizedStringKey : Equatable, ExpressibleByStringInterpolation {
	public init(_ value: String)

	/// Creates an instance initialized to the given string value.
	///  - Parameter value: The value of the new instance.
	public init(stringLiteral value: String)

	/// Creates an instance from a string interpolation.
	///
	/// Most `StringInterpolation` types will store information about the
	/// literals and interpolations appended to them in one or more properties.
	/// `init(stringInterpolation:)` should use these properties to initialize
	/// the instance.
	///
	/// - Parameter stringInterpolation: An instance of `StringInterpolation`
	///             which has had each segment of the string literal appended
	///             to it.
	public init(stringInterpolation: LocalizedStringKey.StringInterpolation)

	/// The type each segment of a string literal containing interpolations
	/// should be appended to.
	///  The `StringLiteralType` of an interpolation type must match the
	/// `StringLiteralType` of the conforming type.
	public struct StringInterpolation : StringInterpolationProtocol {
		/// Creates an empty instance ready to be filled with string literal content.
		///
		/// Don't call this initializer directly. Instead, initialize a variable or
		/// constant using a string literal with interpolated expressions.
		///
		/// Swift passes this initializer a pair of arguments specifying the size of
		/// the literal segments and the number of interpolated segments. Use this
		/// information to estimate the amount of storage you will need.
		///
		/// - Parameter literalCapacity: The approximate size of all literal segments
		///   combined. This is meant to be passed to `String.reserveCapacity(_:)`;
		///   it may be slightly larger or smaller than the sum of the counts of each
		///   literal segment.
		/// - Parameter interpolationCount: The number of interpolations which will be
		///   appended. Use this value to estimate how much additional capacity will
		///   be needed for the interpolated segments.
		public init(literalCapacity: Int, interpolationCount: Int)

		/// Appends a literal segment to the interpolation.
		///
		/// Don't call this method directly. Instead, initialize a variable or
		/// constant using a string literal with interpolated expressions.
		///
		/// Interpolated expressions don't pass through this method; instead, Swift
		/// selects an overload of `appendInterpolation`. For more information, see
		/// the top-level `StringInterpolationProtocol` documentation.
		///
		/// - Parameter literal: A string literal containing the characters
		///   that appear next in the string literal.
		public mutating func appendLiteral(_ literal: String)

		public mutating func appendInterpolation(_ string: String)

		public mutating func appendInterpolation<Subject>(_ subject: Subject, formatter: Formatter? = nil) where Subject : ReferenceConvertible

		public mutating func appendInterpolation<Subject>(_ subject: Subject, formatter: Formatter? = nil) where Subject : NSObject

		public mutating func appendInterpolation<T>(_ value: T) where T : _FormatSpecifiable

		public mutating func appendInterpolation<T>(_ value: T, specifier: String) where T : _FormatSpecifiable

		/// The type that should be used for literal segments.
		public typealias StringLiteralType = String
	}
	public typealias StringLiteralType = String
	public typealias ExtendedGraphemeClusterLiteralType = String
	public typealias UnicodeScalarLiteralType = String
}

/// A gesture that ends once a long-press event sequence has been
/// recognized.
public struct LongPressGesture {
	/// The duration that must elapse before the gesture ends.
	public var minimumDuration: Double

	/// The maximum distance the event can move before the gesture fails.
	public var maximumDistance: Length
	public init(minimumDuration: Double = 0.5, maximumDistance: Length = 10)

	/// The type of value produced by this gesture.
	public typealias Value = Bool

	public typealias Body = Never
}

extension LongPressGesture : Gesture {
}

/// A gesture that tracks how a magnification event sequence changes.
public struct MagnificationGesture : Gesture {
	/// The minimum delta required before the gesture starts.
	public var minimumScaleDelta: CGFloat
	public init(minimumScaleDelta: CGFloat = 0.01)

	/// The type of value produced by this gesture.
	public typealias Value = CGFloat

	public typealias Body = Never
}

open class NSHostingController<Content> : NSViewController where Content : View {
	public init(rootView: Content)
	public init?(coder: NSCoder, rootView: Content)

	@objc required dynamic public init?(coder: NSCoder)
	public var rootView: Content
	public func sizeThatFits(in size: CGSize) -> CGSize

	@objc override dynamic public init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?)
}

/// An `NSView` which hosts a `View` hierarchy.
open class NSHostingView<Content> : NSView, NSUserInterfaceValidations, NSDraggingSource where Content : View {
	required public init(rootView: Content)

	@objc required dynamic public init?(coder aDecoder: NSCoder)

	@objc override final public var isFlipped: Bool

	@objc override dynamic open func renewGState()

	@objc override dynamic open var intrinsicContentSize: NSSize { get }

	@objc override dynamic open class var requiresConstraintBasedLayout: Bool { get }

	@objc override dynamic open func updateConstraints()

	@objc override dynamic open var layerContentsRedrawPolicy: NSView.LayerContentsRedrawPolicy

	@objc override dynamic open func layout()

	@objc override dynamic open func setFrameSize(_ newSize: NSSize)

	/// The root `View` of the view hierarchy to display.
	public var rootView: Content

	@objc override dynamic open func viewDidChangeBackingProperties()

	@objc override dynamic open func viewDidChangeEffectiveAppearance()

	@objc override dynamic open var userInterfaceLayoutDirection: NSUserInterfaceLayoutDirection

	@objc override dynamic open func viewWillMove(toWindow newWindow: NSWindow?)

	@objc override dynamic open func viewDidMoveToWindow()

	@objc override dynamic open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)

	@objc override dynamic open func hitTest(_ point: NSPoint) -> NSView?

	@objc override dynamic open var acceptsFirstResponder: Bool { get }

	@objc override dynamic open var needsPanelToBecomeKey: Bool { get }

	@objc override dynamic open var canBecomeKeyView: Bool { get }

	@objc override dynamic open func magnify(with event: NSEvent)

	@objc override dynamic open func rotate(with event: NSEvent)

	@objc override dynamic open func mouseDown(with event: NSEvent)

	@objc override dynamic open func mouseDragged(with event: NSEvent)

	@objc override dynamic open func mouseUp(with event: NSEvent)

	@objc override dynamic open func rightMouseDown(with event: NSEvent)

	@objc override dynamic open func rightMouseDragged(with event: NSEvent)

	@objc override dynamic open func rightMouseUp(with event: NSEvent)

	@objc override dynamic open func otherMouseDown(with event: NSEvent)

	@objc override dynamic open func otherMouseDragged(with event: NSEvent)

	@objc override dynamic open func otherMouseUp(with event: NSEvent)

	@objc override dynamic open func mouseEntered(with event: NSEvent)

	@objc override dynamic open func mouseExited(with event: NSEvent)

	@objc override dynamic open func scrollWheel(with event: NSEvent)

	@objc override dynamic open func touchesBegan(with event: NSEvent)

	@objc override dynamic open func touchesMoved(with event: NSEvent)

	@objc override dynamic open func touchesEnded(with event: NSEvent)

	@objc override dynamic open func touchesCancelled(with event: NSEvent)

	@objc override dynamic open func menu(for event: NSEvent) -> NSMenu?

	@objc override dynamic open func accessibilityChildren() -> [Any]?

	@objc override dynamic open func accessibilityHitTest(_ point: NSPoint) -> Any?

	@objc public func validateUserInterfaceItem(_ item: NSValidatedUserInterfaceItem) -> Bool

	@objc override dynamic open func responds(to selector: Selector!) -> Bool

	@objc override dynamic open func forwardingTarget(for selector: Selector!) -> Any?

	@objc public func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation

	@objc override dynamic public init(frame frameRect: NSRect)
}

extension NSHostingView {
}

/// A view that represents a `NSViewController`.
///
/// In the lifetime of a representable view, its `NSViewController` and
/// `Coordinator` will be initialized, (often repeatedly) updated, and
/// eventually deinitialized.
///
/// For each phase the following methods will be called in order:
///
///     // Initialization phase:
///     makeCoordinator()
///     makeNSViewController(context:)
///     updateNSViewController(_:context:)
///
///     // Update phase:
///     updateNSViewController(_:context:)
///
///     // Deinitialization phase:
///     dismantleNSViewController(_:coordinator:)
///
public protocol NSViewControllerRepresentable : _UnaryView where Self.Body == Never {
	/// The type of `NSViewController` to be presented.
	associatedtype NSViewControllerType : NSViewController

	/// Creates a `NSViewController` instance to be presented.
	func makeNSViewController(context: Self.Context) -> Self.NSViewControllerType

	/// Updates the presented `NSViewController` (and coordinator) to the latest
	/// configuration.
	func updateNSViewController(_ nsViewController: Self.NSViewControllerType, context: Self.Context)

	/// Cleans up the presented `NSViewController` (and coordinator) in
	/// anticipation of their removal.
	static func dismantleNSViewController(_ nsViewController: Self.NSViewControllerType, coordinator: Self.Coordinator)

	/// A type to coordinate with the `NSViewController`.
	associatedtype Coordinator = Void

	/// Creates a `Coordinator` instance to coordinate with the
	/// `NSViewController`.
	///  `Coordinator` can be accessed via `Context`.
	func makeCoordinator() -> Self.Coordinator

	typealias Context = NSViewControllerRepresentableContext<Self>
}

extension NSViewControllerRepresentable where Self.Coordinator == Void {
	public func makeCoordinator() -> Self.Coordinator
}

extension NSViewControllerRepresentable {
	public static func dismantleNSViewController(_ nsViewController: Self.NSViewControllerType, coordinator: Self.Coordinator)
	public var body: Never { get }
}

/// The context in which an associated NSViewController instance is updated.
public struct NSViewControllerRepresentableContext<ViewController> where ViewController : NSViewControllerRepresentable {
	/// The view's associated coordinator.
	public let coordinator: ViewController.Coordinator

	/// The current `Transaction`.
	public var transaction: Transaction { get }

	/// The current `Environment`.
	public var environment: EnvironmentValues { get }
}

/// A view that represents a `NSView`.
///
/// In the lifetime of a representable view, its `NSView` and
/// `Coordinator` will be initialized, (often repeatedly) updated, and
/// eventually deinitialized.
///
/// For each phase the following methods will be called in order:
///
///     // Initialization phase:
///     makeCoordinator()
///     makeNSView(context:)
///     updateNSView(_:context:)
///
///     // Update phase:
///     updateNSView(_:context:)
///
///     // Deinitialization phase:
///     dismantleNSView(_:coordinator:)
///
public protocol NSViewRepresentable : _UnaryView where Self.Body == Never {
	/// The type of `NSView` to be presented.
	associatedtype NSViewType : NSView

	/// Creates a `NSView` instance to be presented.
	func makeNSView(context: Self.Context) -> Self.NSViewType

	/// Updates the presented `NSView` (and coordinator) to the latest
	/// configuration.
	func updateNSView(_ nsView: Self.NSViewType, context: Self.Context)

	/// Cleans up the presented `NSView` (and coordinator) in
	/// anticipation of their removal.
	static func dismantleNSView(_ nsView: Self.NSViewType, coordinator: Self.Coordinator)

	/// A type to coordinate with the `NSView`.
	associatedtype Coordinator = Void

	/// Creates a `Coordinator` instance to coordinate with the
	/// `NSView`.
	///  `Coordinator` can be accessed via `Context`.
	func makeCoordinator() -> Self.Coordinator

	typealias Context = NSViewRepresentableContext<Self>
}

extension NSViewRepresentable where Self.Coordinator == Void {
	public func makeCoordinator() -> Self.Coordinator
}

extension NSViewRepresentable {
	public static func dismantleNSView(_ nsView: Self.NSViewType, coordinator: Self.Coordinator)
	public var body: Never { get }
}

/// The context in which an associated NSView instance is updated.
public struct NSViewRepresentableContext<View> where View : NSViewRepresentable {
	/// The view's associated coordinator.
	public let coordinator: View.Coordinator

	/// The current `Transaction`.
	public var transaction: Transaction { get }

	/// The current `Environment`.
	public var environment: EnvironmentValues { get }
}

/// A button that triggers a navigation presentation when pressed.
public struct NavigationButton<Label, Destination> where Label : View, Destination : View {
	/// Creates an instance that pushes `destination` onto a navigation stack
	/// when triggered.
	public init(destination: Destination, isDetail: Bool = true, onTrigger: @escaping () -> Bool = { true }, label: () -> Label)

	/// Creates an instance that pushes the view represented by `destination`
	/// onto a navigation stack when triggered.
	public init(destination: NavigationDestinationLink<Destination>, onTrigger: @escaping () -> Bool = { true }, label: () -> Label)

	/// Creates an instance that pushes the view represented by `destination`,
	/// generated from `data`, onto a navigation stack when triggered.
	public init<Data, ID>(destination: DynamicNavigationDestinationLink<Data, ID, Destination>, presenting data: Data, onTrigger: @escaping () -> Bool = { true }, label: () -> Label) where Data : Hashable, ID : Hashable
	public var body: _View { get }

	public typealias Body
}

/// A `DynamicViewProperty` representing a unique destination in a navigation
/// stack.
public struct NavigationDestinationLink<Content> : DynamicViewProperty where Content : View {
	/// A `Binding` indicating if `self` is currently presenting its content.
	///  If `nil`, then no presentation is possible; that is, `self` is declared
	/// on a view that is not contained within a `NavigationView`.
	public var presented: Binding<Bool>? { get }

	/// Creates an instance representing a unique destination in a navigation
	/// stack that displays `content`.
	public init(_ content: Content, isDetail: Bool = true)
}

/// A view for presenting a stack of views representing a visible path in a
/// navigation hierarchy.
public struct NavigationView<Root> where Root : View {
	public init(root: () -> Root)
	public var body: _View { get }

	public typealias Body
}

/// A dynamic view property that subscribes to a `BindableObject` automatically invalidating the view
/// when it changes.
@propertyDelegate public struct ObjectBinding<BindableObjectType> : DynamicViewProperty where BindableObjectType : BindableObject {
	/// A wrapper of the underlying `BindableObject` that can create `Binding`s to its properties
	/// using dynamic member lookup.
	@dynamicMemberLookup public struct Wrapper {
		/// Creates a `Binding` to a value semantic property of a reference type.
		///
		/// If `Value` is not value semantic, the updating behavior for any views
		/// that make use of the resulting `Binding` is unspecified.
		public subscript<Subject>(dynamicMember keyPath: ReferenceWritableKeyPath<BindableObjectType, Subject>) -> Binding<Subject> { get }
	}
	public var value: BindableObjectType
	public init(initialValue: BindableObjectType)
	public var delegateValue: ObjectBinding<BindableObjectType>.Wrapper { get }
	public var storageValue: ObjectBinding<BindableObjectType>.Wrapper { get }
}

extension ObjectBinding {
}

/// A shape with a translation offset applied to it.
public struct OffsetShape<S> : Shape where S : Shape {
	public var shape: S
	public var offset: CGSize

	@inlinable public init(shape: S, offset: CGSize)

	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in rect: CGRect) -> Path

	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<S.AnimatableData, CGSize.AnimatableData>

	/// The data to be animated.
	public var animatableData: AnimatablePair<S.AnimatableData, CGSize.AnimatableData>

	public typealias Body = ShapeView<OffsetShape<S>, ForegroundStyle>
}

/// The configuration when applying an `.onInsert` modifier.
public struct OnInsertConfiguration {
}

/// A system Button that enables reading data from the pasteboard in
/// response to being triggered.
///
/// Currently, `PasteButton` will not automatically invalidate on pasteboard
/// changes, and so should be mainly used in transient contexts like in
/// `ContextMenu`.
public struct PasteButton {
	/// Creates an instance that is filtered to accepting specific type
	/// identifiers from the pasteboard.
	///  - Parameters:
	///   - supportedTypes: The exact uniform type identifiers supported by the
	///     button. If the pasteboard does not contain any of the supported
	///     types, the button will be disabled.
	///   - onTrigger: The handler to call on trigger of the button with the
	///     items from the pasteboard that conform to `supportedTypes`.
	///  `supportedTypes` is ordered based on preference of types. The pasteboard
	/// items provided to `dataHandler` will have a type that is the most
	/// preferred type out of all the types the source supports.
	public init(supportedTypes: [String], onTrigger: @escaping ([NSItemProvider]) -> Void)

	/// Creates an instance that is filtered to accepting specific type
	/// identifiers from the pasteboard, as well as allows custom validation
	/// of the data conforming to those types.
	///  - Parameters:
	///   - supportedTypes: The exact uniform type identifiers supported by the
	///     button. If the pasteboard does not contain any of the supported
	///     types, the button will be disabled.
	///   - validator: The handler that is called on validation of the button
	///     with items from the pasteboard that conform to `supportedTypes`. The
	///     return result of `validator` will be provided to `dataHandler` on
	///     trigger of the button. If `nil` is returned, the button will be
	///     disabled.
	///   - onTrigger: The handler to call on trigger of the button with the
	///     pre-processed result of `validator`.
	///  `supportedTypes` is ordered based on preference of types. The pasteboard
	/// items provided to `validator` will have a type that is the most
	/// preferred type out of all the types the source supports.
	public init<Payload>(supportedTypes: [String], validator: @escaping ([NSItemProvider]) -> Payload?, onTrigger: @escaping (Payload) -> Void)
	public var body: _View { get }

	public typealias Body
}

/// Describes an outline of a 2D shape.
public struct Path : Equatable {
	/// Initialize with an empty path.
	public init()

	/// Initialize from the immutable shape `path`.
	public init(_ path: CGPath)

	/// Initialize from a copy of the mutable shape `path`.
	public init(_ path: CGMutablePath)

	/// Initialize as the rectangle `rect`.
	public init(_ rect: CGRect)

	/// Initialize as the rounded rectangle `rect`.
	public init(roundedRect rect: CGRect, cornerSize: CGSize, style: RoundedCornerStyle = .circular)

	/// Initialize as the rounded rectangle `rect`.
	public init(roundedRect rect: CGRect, cornerRadius: Length, style: RoundedCornerStyle = .circular)

	/// Initialize as an ellipse inscribed within `rect`.
	public init(ellipseIn rect: CGRect)

	/// Initializes to an empty path then calls `callback` to add
	/// the initial elements.
	public init(_ callback: (inout Path) -> ())

	/// Initializes from the result of a previous call to
	/// `Path.stringRepresentation`. Fails if the `string` does not
	/// describe a valid path.
	public init?(string: String)

	/// A description of the path that may be used to recreate the path
	/// via `init?(string:)`.
	public var stringRepresentation: String { get }

	/// An immutable CGPath representing the elements in the path.
	public var cgPath: CGPath { get }

	/// True if the path contains no elements.
	public var isEmpty: Bool { get }

	/// A rectangle containing all path segments.
	public var boundingRect: CGRect { get }

	/// Returns true if the path contains point `p`. If `eoFill` is
	/// true the even-odd rule is used to define which points are
	/// inside the path, otherwise the non-zero rule is used.
	public func contains(_ p: CGPoint, eoFill: Bool = false) -> Bool

	/// An element of a path.
	public enum Element : Equatable {
		/// Terminates the current subpath (without closing it) and
		/// defines a new current point.
		case move(to: CGPoint)

		/// A line from the previous current point to the given point,
		/// which becomes the new current point.
		case line(to: CGPoint)

		/// A quadratic bezier curve from the previous current point to
		/// the given end-point, using the single control point to
		/// define the curve. The end-point becomes the new current
		/// point.
		case quadCurve(to: CGPoint, control: CGPoint)

		/// A cubic bezier curve from the previous current point to the
		/// given end-point, using the two control points to define the
		/// curve. The end-point becomes the new current point.
		case curve(to: CGPoint, control1: CGPoint, control2: CGPoint)

		/// If a subpath is active, draws a line from its start point
		/// to the current point, terminating the subpath. The current
		/// point is undefined afterwards.
		case closeSubpath

	}

	/// Calls `body` with each element in the path.
	public func forEach(_ body: (Path.Element) -> Void)

	/// Returns a stroked copy of the path using `style` to define how
	/// the stroked outline is created.
	public func strokedPath(_ style: StrokeStyle) -> Path

	/// Returns a partial copy of the path, containing the region
	/// between `from` and `to`, both of which must be fractions
	/// between zero and one defining points linearly-interpolated
	/// along the path.
	public func trimmedPath(from: CGFloat, to: CGFloat) -> Path
}

extension Path : Shape {
	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in _: CGRect) -> Path

	/// The type defining the data to be animated.
	public typealias AnimatableData = EmptyAnimatableData

	public typealias Body = ShapeView<Path, ForegroundStyle>
}

extension Path {
	/// Begins a new subpath at the specified point.
	public mutating func move(to p: CGPoint)

	/// Appends a straight line segment from the current point to the
	/// specified point.
	public mutating func addLine(to p: CGPoint)

	/// Adds a quadratic Bézier curve to the path, with the
	/// specified end point and control point.
	public mutating func addQuadCurve(to p: CGPoint, control cp: CGPoint)

	/// Adds a cubic Bézier curve to the path, with the
	/// specified end point and control points.
	public mutating func addCurve(to p: CGPoint, control1 cp1: CGPoint, control2 cp2: CGPoint)

	/// Closes and completes the current subpath.
	public mutating func closeSubpath()

	/// Adds a rectangular subpath to the path.
	public mutating func addRect(_ rect: CGRect, transform: CGAffineTransform = .identity)

	/// Adds a rounded rectangle to the path.
	public mutating func addRoundedRect(in rect: CGRect, cornerSize: CGSize, style: RoundedCornerStyle = .circular, transform: CGAffineTransform = .identity)

	/// Adds an ellipse to the path.
	public mutating func addEllipse(in rect: CGRect, transform: CGAffineTransform = .identity)

	/// Adds a sequence of rectangular subpaths to the path.
	public mutating func addRects(_ rects: [CGRect], transform: CGAffineTransform = .identity)

	/// Adds a sequence of connected straight-line segments to the
	/// path.
	public mutating func addLines(_ lines: [CGPoint])

	/// Adds an arc of a circle to the path, specified with a radius
	/// and a difference in angle.
	public mutating func addRelativeArc(center: CGPoint, radius: Length, startAngle: Angle, delta: Angle, transform: CGAffineTransform = .identity)

	/// Adds an arc of a circle to the path, specified with a radius
	/// and angles.
	public mutating func addArc(center: CGPoint, radius: Length, startAngle: Angle, endAngle: Angle, clockwise: Bool, transform: CGAffineTransform = .identity)

	/// Adds an arc of a circle to the path, specified with a radius
	/// and two tangent lines.
	public mutating func addArc(tangent1End p1: CGPoint, tangent2End p2: CGPoint, radius: Length, transform: CGAffineTransform = .identity)

	/// Appends a copy of `path` to the path.
	public mutating func addPath(_ path: Path, transform: CGAffineTransform = .identity)

	/// Returns a path constructed by applying `transform` to all
	/// points of `self`.
	public func applying(_ transform: CGAffineTransform) -> Path

	/// Returns a path constructed by translating `self` by `(dx, dy)`.
	public func offsetBy(dx: Length, dy: Length) -> Path
}

/// A control for selecting from a set of mutually exclusive values.
///
/// - SeeAlso: `ViewContent.tag(_:)
public struct Picker<Label, SelectionValue, Content> where Label : View, SelectionValue : Hashable, Content : View {
	/// Creates an instance that selects from content associated with
	/// `Selection` values.
	public init(selection: Binding<SelectionValue>, label: Label, content: () -> Content)

	public typealias Body = Never
}

extension Picker : View {
}

/// A custom specification for the appearance and interaction of a `Picker`.
public protocol PickerStyle {
	/// The complete specification of a `Picker` for purposes of creating a
	/// `PickerStyle`.
	typealias Configuration<S>
}

extension PickerStyle {
	public typealias Member = StaticMember<Self>
}

/// A `ListStyle` that implements the system default `List` interaction
/// and appearance.
public struct PlainListStyle : ListStyle {
}

public struct PlainTextFieldStyle : TextFieldStyle {
}

/// A type that coordinates changes coming from a `PlatformViewRepresentable`.
@objc public class PlatformViewCoordinator : NSObject {
	@objc override dynamic public init()
}

/// Popover Presentation API
public struct Popover {
	/// The content view of the popover.
	public var content: AnyView

	/// The edge of the targetAnchor which the popover attaches to.
	public var popoverArrowEdge: Edge?

	/// The positioning rect which defines where the popover is attached.
	public var targetAnchor: Anchor<CGRect>.Source

	/// Action which informs the caller when the popover has been dismissed.
	public var dismissHandler: () -> Void

	/// Action which allows the caller to indicate if the popver should detach.
	public var detachHandler: (() -> Bool)?

	/// Creates a popover attached to an anchor rect.
	public init<V>(content: V, targetRect: Anchor<CGRect>.Source = .bounds, popoverArrowEdge: Edge? = .top, dismissHandler: @escaping () -> Void) where V : View

	/// Creates a popover attached to an anchor point.
	public init<V>(content: V, targetPoint: UnitPoint, popoverArrowEdge: Edge? = .top, dismissHandler: @escaping () -> Void) where V : View
}

/// A named value produced by a view. Views with multiple children
/// automatically combine all child values into a single value visible
/// to their ancestors.
public protocol PreferenceKey {
	/// The type of value produced by the preference.
	associatedtype Value

	/// The default value of the preference reduction; this is the
	/// value that will be implicitly produced by views that have no
	/// explicit value for the key. Implicit values may be removed from
	/// the reduction sequence, this means that `reduce(value: &x,
	/// nextValue: { defaultValue })` should not change the meaning of
	/// `x`.
	static var defaultValue: Self.Value { get }

	/// Given the current value of the reduction, and a function that
	/// returns the next value in the sequence of input values, updates
	/// the current value to reflect the next value. Values will be
	/// supplied in view-tree order.
	static func reduce(value: inout Self.Value, nextValue: () -> Self.Value)
}

extension PreferenceKey where Self.Value : ExpressibleByNilLiteral {
	/// Let nil-expressible values default-initialize to nil.
	public static var defaultValue: Self.Value { get }
}

extension PreferenceKey {
}

/// A control which presents content when triggered.
public struct PresentationButton<Label, Destination> where Label : View, Destination : View {
	/// A `View` to use as the label of the button.
	public var label: Label

	/// A `View` to present.
	public var destination: Destination

	/// A closure to be invoked when the button is tapped.
	public var onTrigger: (() -> Void)?
	public init(_ label: Label, destination: Destination, onTrigger: (() -> Void)? = nil)
	public var body: _View { get }

	public typealias Body
}

/// The simulator device for running a preview on.
///
/// This can be a marketing name as it appears in Xcode's run destination menu
/// (e.g. "iPhone X") or a model number (iPad8,1).
public struct PreviewDevice : RawRepresentable, ExpressibleByStringLiteral {
	/// Creates an instance initialized to the given string value.
	///  - Parameter value: The value of the new instance.
	public init(stringLiteral: String)

	public typealias RawValue = String
	public typealias StringLiteralType = String
	public typealias ExtendedGraphemeClusterLiteralType = String
	public typealias UnicodeScalarLiteralType = String
}

/// The size constraint for a preview.
public enum PreviewLayout {
	/// Centers the preview in a container the size of the device the preview
	/// is running on.
	case device

	/// Fits the container to the size of the preview (when offered the size
	/// of the device the preview is running on).
	case sizeThatFits

	/// Centers the preview in a fixed size container.
	case fixed(width: Length, height: Length)
}

/// OS platform for running a preview on.
public enum PreviewPlatform {
	case iOS
	case macOS
	case tvOS
	case watchOS
}

/// Produces view previews in Xcode.
///
/// Xcode statically discovers types that conform to `PreviewProvider` and
/// generates previews in the canvas for each provider it discovers.
public protocol PreviewProvider : _PreviewProvider {
	/// The type of the previews variable.
	associatedtype Previews : View

	/// Generates a collection of previews.
	///  Example:
	/// 	struct MyPreviews : PreviewProvider {
	///         static var previews: some View {
	///             return Group {
	///                 GreetingView("Hello"),
	///                 GreetingView("Guten Tag"),
	/// 	            ForEach(otherGreetings.identified(by: \.self_)) {
	///                     GreetingView($0)
	///                 }
	///             ]
	///             .previewDevice("iPhone X")
	///         }
	///     }
	static var previews: Self.Previews { get }

	/// Returns which platform to run the provider on.
	///  When `nil`, Xcode infers the platform based on the file the
	/// `PreviewProvider` is defined in. This should only be provided when the
	/// file is in targets that support multiple platforms.
	static var platform: PreviewPlatform? { get }
}

extension PreviewProvider {
	public static var platform: PreviewPlatform? { get }
}

public struct ProjectionTransform {
	public var m11: CGFloat
	public var m12: CGFloat
	public var m13: CGFloat
	public var m21: CGFloat
	public var m22: CGFloat
	public var m23: CGFloat
	public var m31: CGFloat
	public var m32: CGFloat
	public var m33: CGFloat

	@inlinable public init()

	@inlinable public init(_ m: CGAffineTransform)

	@inlinable public init(_ m: CATransform3D)

	@inlinable public var isIdentity: Bool { get }

	@inlinable public var isAffine: Bool { get }
	public mutating func invert() -> Bool
	public func inverted() -> ProjectionTransform
}

extension ProjectionTransform : Equatable {
}

extension ProjectionTransform {
	@inlinable public func concatenating(_ rhs: ProjectionTransform) -> ProjectionTransform
}

/// A control for selecting an item from a pull-down menu.
public struct PullDownButton<Label, Content> where Label : View, Content : View {
	/// Creates an instance that selects from content associated with
	/// `Selection` values.
	public init(label: Label, content: () -> Content)

	public typealias Body = Never
}

/// A radial gradient. The gradient's color function is applied as the
/// distance from a center point, scaled to fit within defined start
/// and end radii. The unit-space center point is mapped into the
/// bounding rectangle of each shape filled with the gradient.
public struct RadialGradient : ShapeStyle {
	public init(gradient: Gradient, center: UnitPoint, startRadius: Length, endRadius: Length)
}

/// A rectangular shape aligned inside the frame of the view containing
/// it.
public struct Rectangle : Shape {
	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in rect: CGRect) -> Path

	@inlinable public init()

	/// The type defining the data to be animated.
	public typealias AnimatableData = EmptyAnimatableData

	public typealias Body = ShapeView<Rectangle, ForegroundStyle>
}

extension Rectangle : InsettableShape {
	/// Returns `self` inset by `amount`.
	public func inset(by amount: Length) -> Rectangle._Inset

	/// The type of the inset shape.
	public typealias InsetShape
}

/// A shape with a rotation transform translation applied to it.
public struct RotatedShape<S> : Shape where S : Shape {
	public var shape: S
	public var angle: Angle
	public var anchor: UnitPoint

	@inlinable public init(shape: S, angle: Angle, anchor: UnitPoint = .center)

	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in rect: CGRect) -> Path

	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<S.AnimatableData, AnimatablePair<Angle.AnimatableData, UnitPoint.AnimatableData>>

	/// The data to be animated.
	public var animatableData: AnimatablePair<S.AnimatableData, AnimatablePair<Angle.AnimatableData, UnitPoint.AnimatableData>>

	public typealias Body = ShapeView<RotatedShape<S>, ForegroundStyle>
}

/// A gesture that tracks how a rotation event sequence changes.
public struct RotationGesture : Gesture {
	/// The minimum delta required before the action runs.
	public var minimumAngleDelta: Angle
	public init(minimumAngleDelta: Angle = .degrees(1))

	/// The type of value produced by this gesture.
	public typealias Value = Angle

	public typealias Body = Never
}

public struct RoundedBorderTextFieldStyle : TextFieldStyle {
}

/// Defines the shape of a rounded rectangle's corners.
public enum RoundedCornerStyle {
	/// Quarter-circle rounded rect corners.
	case circular

	/// Continuous curvature rounded rect corners.
	case continuous
}

/// A rectangular shape with rounded corners, aligned inside the frame
/// of the view containing it.
public struct RoundedRectangle : Shape {
	public var cornerSize: CGSize
	public var style: RoundedCornerStyle

	@inlinable public init(cornerSize: CGSize, style: RoundedCornerStyle = .circular)

	@inlinable public init(cornerRadius: Length, style: RoundedCornerStyle = .circular)

	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in rect: CGRect) -> Path

	/// The data to be animated.
	public var animatableData: CGSize.AnimatableData

	/// The type defining the data to be animated.
	public typealias AnimatableData = CGSize.AnimatableData

	public typealias Body = ShapeView<RoundedRectangle, ForegroundStyle>
}

extension RoundedRectangle : InsettableShape {
	/// Returns `self` inset by `amount`.
	@inlinable public func inset(by amount: Length) -> RoundedRectangle._Inset

	/// The type of the inset shape.
	public typealias InsetShape
}

/// A shape with a scale transform translation applied to it.
public struct ScaledShape<S> : Shape where S : Shape {
	public var shape: S
	public var scale: CGSize
	public var anchor: UnitPoint

	@inlinable public init(shape: S, scale: CGSize, anchor: UnitPoint = .center)

	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in rect: CGRect) -> Path

	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<S.AnimatableData, AnimatablePair<CGSize.AnimatableData, UnitPoint.AnimatableData>>

	/// The data to be animated.
	public var animatableData: AnimatablePair<S.AnimatableData, AnimatablePair<CGSize.AnimatableData, UnitPoint.AnimatableData>>

	public typealias Body = ShapeView<ScaledShape<S>, ForegroundStyle>
}

/// A scroll view.
///
/// The `content` is displayed within the scrollable content region.
public struct ScrollView<Content> where Content : View {
	/// The content of the scroll view.
	public var content: Content

	/// If false, interactive scrolling is disabled.
	///  The default is `true`.
	public var isScrollEnabled: Bool

	/// If true the scroll view can be bounced horizontally, even if its
	/// content width is less than the view width.
	///  The default is `false`.
	public var alwaysBounceHorizontal: Bool

	/// If true the scroll view can be bounced vertically, even if its
	/// content height is less than the view height.
	///  The default is `false`.
	public var alwaysBounceVertical: Bool

	/// If true, the scroll view may indicate the horizontal component
	/// of the content offset, in a way suitable for the platform.
	///  The default is `true`.
	public var showsHorizontalIndicator: Bool

	/// If true, the scroll view may indicate the vertical component of
	/// the content offset, in a way suitable for the platform.
	///  The default is `true`.
	public var showsVerticalIndicator: Bool
	public init(isScrollEnabled: Bool = true, alwaysBounceHorizontal: Bool = false, alwaysBounceVertical: Bool = false, showsHorizontalIndicator: Bool = true, showsVerticalIndicator: Bool = true, content: () -> Content)
	public var body: _View { get }

	public typealias Body
}

/// An affordance for creating hierarchical view content.
public struct Section<Parent, Content, Footer> where Parent : View, Content : View, Footer : View {
	public init(header: Parent, footer: Footer, content: () -> Content)

	public typealias Body = Never
}

extension Section where Parent == EmptyView {
	public init(footer: Footer, content: () -> Content)
}

extension Section where Footer == EmptyView {
	public init(header: Parent, content: () -> Content)
}

extension Section where Parent == EmptyView, Footer == EmptyView {
	public init(content: () -> Content)
}

/// A control that allows entry of private user text contents that should be
/// kept secure.
///
/// - SeeAlso: `View.textContentType(_:)`
public struct SecureField {
	public init(_ text: Binding<String>, placeholder: Text? = nil, onCommit: @escaping () -> Void = {})
	public var body: _View { get }

	public typealias Body
}

/// A control for selecting from a set of options.
///
/// `SegmentedControl` only supports segments of type `Label` and `Image`.
/// Passing any other type of view will result in a visible, empty segment.
public struct SegmentedControl<SelectionValue, Content> where SelectionValue : Hashable, Content : View {
	/// Creates an instance that selects from content associated with
	/// `Selection` values.
	public init(selection: Binding<SelectionValue>, content: () -> Content)

	public typealias Body = Never
}

/// A type that represents information about a selection.
public protocol SelectionManager {
	associatedtype SelectionValue : Hashable

	/// Selects `value`.
	mutating func select(_ value: Self.SelectionValue)

	/// Deselects `value`.
	mutating func deselect(_ value: Self.SelectionValue)

	/// Whether `value` is currently selected.
	func isSelected(_ value: Self.SelectionValue) -> Bool

	/// Whether multiple selection is allowed. The default value is `true`.
	var allowsMultipleSelection: Bool { get }
}

extension SelectionManager {
	public var allowsMultipleSelection: Bool { get }
}

public struct SelectionShapeStyle : ShapeStyle {
}

public struct SeparatorShapeStyle : ShapeStyle {
}

/// A gesture type that sequences two sub-gestures.
public struct SequenceGesture<First, Second> where First : Gesture, Second : Gesture {
	/// The type of value produced by this gesture.
	public enum Value {
		/// The first gesture has not ended.
		case first(First.Value)

		/// The first gesture has ended.
		case second(First.Value, Second.Value?)
	}
	public var first: First
	public var second: Second

	@inlinable public init(_ first: First, _ second: Second)

	public typealias Body = Never
}

extension SequenceGesture : Gesture {
}

extension SequenceGesture.Value : Equatable where First.Value : Equatable, Second.Value : Equatable {
}

/// A two-dimensional shape you can use as part of drawing a view.
///
/// Shapes without an explicit fill or stroke get a default fill based on the
/// foreground color.
///
/// You can define shapes in relation to an implicit frame of
/// reference --- for example, the natural size of the view that contains it ---
/// or you can define shapes in terms of absolute coordinates.
public protocol Shape : Equatable, Animatable, View {
	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	func path(in rect: CGRect) -> Path
}

extension Shape {
	public typealias Filled<S> = ShapeView<Self, S> where S : ShapeStyle

	/// Fills this shape with a color or gradient.
	///  - Parameters:
	///   - content: The color or gradient to use when filling this shape.
	///   - style: The style options that determine how the fill renders.
	/// - Returns: A shape filled with the color or gradient you supply.
	@inlinable public func fill<S>(_ content: S, style: FillStyle = FillStyle()) -> Self.Filled<S> where S : ShapeStyle

	/// Fills this shape with a color or gradient.
	///  - Parameters:
	///   - content: The color or gradient to use when filling this shape.
	///   - style: The style options that determine how the fill renders.
	/// - Returns: A shape filled with the color or gradient you supply.
	@inlinable public func fill<S>(_ content: S.Member, style: FillStyle = FillStyle()) -> Self.Filled<S> where S : ShapeStyle

	/// Fills this shape with the foreground color.
	///  - Parameter style: The style options that determine how the fill
	///   renders.
	/// - Returns: A shape filled with the foreground color.
	@inlinable public func fill(style: FillStyle = FillStyle()) -> Self.Filled<ForegroundStyle>

	/// Traces the outline of this shape with a color or gradient.
	///  The following example adds a dashed purple stroke to a `Capsule`:
	/// 	Capsule()
	///     .stroke(
	///         Color.purple,
	///         style: StrokeStyle(
	///             lineWidth: 5,
	///             lineCap: .round,
	///             lineJoin: .miter,
	///             miterLimit: 0,
	///             dash: [5, 10],
	///             dashPhase: 0
	///         )
	///     )
	///  - Parameters:
	///   - content: The color or gradient with which to stroke this shape.
	///   - style: The stroke characteristics --- such as the line's width and
	///     whether the stroke is dashed --- that determine how to render this
	///     shape.
	/// - Returns: A stroked shape.
	@inlinable public func stroke<S>(_ content: S, style: StrokeStyle) -> Self.Stroked.Filled<S> where S : ShapeStyle

	/// Traces the outline of this shape with a color or gradient.
	///  - Parameters:
	///   - content: The color or gradient with which to stroke this shape.
	///   - style: The stroke characteristics --- such as the line's width and
	///     whether the stroke is dashed --- that determine how to render this
	///     shape.
	/// - Returns: A stroked shape.
	@inlinable public func stroke<S>(_ content: S.Member, style: StrokeStyle) -> Self.Stroked.Filled<S> where S : ShapeStyle

	/// Traces the outline of this shape with a color or gradient.
	///  The following example draws a circle with a purple stroke:
	/// 	Circle().stroke(Color.purple, lineWidth: 5)
	///  - Parameters:
	///   - content: The color or gradient with which to stroke this shape.
	///   - lineWidth: The width of the stroke that outlines this shape.
	/// - Returns: A stroked shape.
	@inlinable public func stroke<S>(_ content: S, lineWidth: Length = 1) -> Self.Stroked.Filled<S> where S : ShapeStyle

	/// Traces the outline of this shape with a color or gradient.
	///  - Parameters:
	///   - content: The color or gradient with which to stroke this shape.
	///   - lineWidth: The width of the stroke that outlines this shape.
	/// - Returns: A stroked shape.
	@inlinable public func stroke<S>(_ content: S.Member, lineWidth: Length = 1) -> Self.Stroked.Filled<S> where S : ShapeStyle

	/// Traces the outline of this shape with the foreground color.
	///  - Parameter style: The stroke characteristics --- such as the line's
	///   width and whether the stroke is dashed --- that determine how to
	///   render this shape.
	/// - Returns: A stroked shape.
	@inlinable public func stroke(style: StrokeStyle) -> Self.Stroked.Filled<ForegroundStyle>

	/// Traces the outline of this shape with the foreground color.
	///  - Parameter lineWidth: The width of the stroke that outlines this shape.
	/// - Returns: A stroked shape.
	@inlinable public func stroke(lineWidth: Length = 1) -> Self.Stroked.Filled<ForegroundStyle>
}

/// A shape acts as view by filling itself with the foreground color and
/// default fill style.
extension Shape {
	public var body: ShapeView<Self, ForegroundStyle> { get }
}

extension Shape {
	/// Changes the relative position of this shape using the specified size.
	///  The following example shows two circles: One circle at its default
	/// position and another outlined with a stroke is overlaid on top and
	/// offset by 100 points to the left and 50 points below.
	/// 	Circle()
	///     .overlay(
	///         Circle()
	///         .offset(CGSize(width: -100, height: 50))
	///         .stroke()
	///     )
	///  - Parameter offset: The amount, in points, by which you offset the
	///   shape. Negative numbers are to the left and up; positive numbers are
	///   to the right and down.
	/// - Returns: A shape offset by the specified amount.
	@inlinable public func offset(_ offset: CGSize) -> OffsetShape<Self>

	/// Changes the relative position of this shape using the specified point.
	///  The following example shows two circles: One circle at its default
	/// position and another outlined with a stroke is overlaid on top and
	/// offset by 100 points to the left and 50 points below.
	/// 	Circle()
	///     .overlay(
	///         Circle()
	///         .offset(CGPoint(x: -100, y: 50))
	///         .stroke()
	///     )
	///  - Parameter offset: The amount, in points, by which you offset the
	///   shape. Negative numbers are to the left and up; positive numbers are
	///   to the right and down.
	/// - Returns: A shape offset by the specified amount.
	@inlinable public func offset(_ offset: CGPoint) -> OffsetShape<Self>

	/// Changes the relative position of this shape using the specified
	/// coordinates.
	///  The following example shows two circles: One circle at its default
	/// position and another outlined with a stroke is overlaid on top and
	/// offset by 100 points to the left and 50 points below.
	/// 	Circle()
	///     .overlay(
	///         Circle()
	///         .offset(x: -100, y: 50)
	///         .stroke()
	///     )
	///  - Parameters:
	///   - x: The horizontal amount, in points, by which you offset the shape.
	///     Negative numbers are to the left and positive numbers are to the
	///     right.
	///   - y: The vertical amount, in points, by which you offset the shape.
	///     Negative numbers are up and positive numbers are down.
	/// - Returns: A shape offset by the specified amount.
	@inlinable public func offset(x: Length = 0, y: Length = 0) -> OffsetShape<Self>

	/// Scales this shape without changing its bounding frame.
	///  Both the `x` and `y` multiplication factors halve their respective
	/// dimension's size when set to `0.5`, maintain their existing size when
	/// set to `1`, double their size when set to `2`, and so forth.
	///  - Parameters:
	///   - x: The multiplication factor used to resize this shape along its
	///     x-axis.
	///   - y: The multiplication factor used to resize this shape along its
	///     y-axis.
	/// - Returns: A scaled form of this shape.
	@inlinable public func scale(x: CGFloat = 1, y: CGFloat = 1, anchor: UnitPoint = .center) -> ScaledShape<Self>

	/// Scales this shape without changing its bounding frame.
	///  - Parameters:
	///   - scale: The multiplication factor used to resize this shape. A value
	///     of `0` scales the shape to have no size, `0.5` scales to half size
	///     in both dimensions, `2` scales to twice the regular size, and so on.
	/// - Returns: A scaled form of this shape.
	@inlinable public func scale(_ scale: CGFloat, anchor: UnitPoint = .center) -> ScaledShape<Self>

	/// Rotates this shape around an anchor point at the angle you specify.
	///  The following example rotates a square by 45 degrees to create a diamond
	/// shape:
	/// 	RoundedRectangle(cornerRadius: 10)
	///     .rotation(Angle(degrees: 45))
	///     .aspectRatio(1.0, contentMode: .fit)
	///  - Parameters:
	///   - angle: The angle of rotation to apply. Positive angles rotate
	///     clockwise; negative angles rotate counterclockwise.
	///   - anchor: The point to rotate the shape around.
	/// - Returns: A rotated shape.
	@inlinable public func rotation(_ angle: Angle, anchor: UnitPoint = .center) -> RotatedShape<Self>

	/// Applies an affine transform to this shape.
	///  Affine transforms present a mathematical approach to applying
	/// combinations of rotation, scaling, translation, and skew to shapes.
	///  - Parameter transform: The affine transformation matrix to apply to
	///   this shape.
	/// - Returns: A transformed shape, based on its matrix values.
	@inlinable public func transform(_ transform: CGAffineTransform) -> TransformedShape<Self>
}

extension Shape {
	/// Trims this shape by a fractional amount based on its representation as a
	/// path.
	///  To create a `Shape` instance, you define the shape's path using lines and
	/// curves. Use the `trim(from:to:)` method to draw a portion of a shape by
	/// ignoring portions of the beginning and ending of the shape's path.
	///  For example, if you're drawing a figure eight or infinity symbol (∞)
	/// starting from its center, setting the `startFraction` and `endFraction`
	/// to different values determines the parts of the overall shape.
	///  The following example shows a simplified infinity symbol that draws
	/// only three quarters of the full shape. That is, of the two lobes of the
	/// symbol, one lobe is complete and the other is half complete.
	/// 	Path { path in
	///         path.addLines([
	///             .init(x: 2, y: 1),
	///             .init(x: 1, y: 0),
	///             .init(x: 0, y: 1),
	///             .init(x: 1, y: 2),
	///             .init(x: 3, y: 0),
	///             .init(x: 4, y: 1),
	///             .init(x: 3, y: 2),
	///             .init(x: 2, y: 1)
	///         ])
	///     }
	///     .trim(from: 0.25, to: 1.0)
	///     .scale(50, anchor: .topLeading)
	///     .stroke(Color.black, lineWidth: 3)
	///  Changing the parameters of `trim(from:to:)` to
	/// `.trim(from: 0, to: 1)` draws the full infinity symbol, while
	/// `.trim(from: 0, to: 0.5)` draws only the left lobe of the symbol.
	///  - Parameters:
	///   - startFraction: The fraction of the way through drawing this shape
	///     where drawing starts.
	///   - endFraction: The fraction of the way through drawing this shape
	///     where drawing ends.
	/// - Returns: A shape built by capturing a portion of this shape's path.
	@inlinable public func trim(from startFraction: CGFloat = 0, to endFraction: CGFloat = 1) -> TrimmedShape<Self>
}

extension Shape {
	/// Returns a new version of self representing the same shape, but
	/// that will ask it to create its path from a rect of `size`. This
	/// does not affect the layout properties of any views created from
	/// the shape (e.g. by filling it).
	@inlinable public func size(_ size: CGSize) -> SizedShape<Self>

	/// Returns a new version of self representing the same shape, but
	/// that will ask it to create its path from a rect of size
	/// `(width, height)`. This does not affect the layout properties
	/// of any views created from the shape (e.g. by filling it).
	@inlinable public func size(width: Length, height: Length) -> SizedShape<Self>
}

extension Shape {
	public typealias Stroked = StrokedShape<Self>

	/// Returns a new shape that is a stroked copy of `self`, using the
	/// contents of `style` to define the stroke characteristics.
	@inlinable public func stroke(style: StrokeStyle) -> Self.Stroked

	/// Returns a new shape that is a stroked copy of `self` with
	/// line-width defined by `lineWidth` and all other properties of
	/// `StrokeStyle` having their default values.
	@inlinable public func stroke(lineWidth: Length) -> Self.Stroked
}

/// A way to turn a shape into a view.
public protocol ShapeStyle {
}

extension ShapeStyle {
	/// Return a new paint value matching `self` except using `rect` to
	/// map unit-space coordinates to absolute coordinates.
	@inlinable public func `in`(_ rect: CGRect) -> AnchoredShapeStyle<Self>
}

extension ShapeStyle {
	public typealias Member = StaticMember<Self>
}

public struct ShapeView<Content, Style> where Content : Shape, Style : ShapeStyle {
	public var shape: Content
	public var style: Style
	public var fillStyle: FillStyle

	@inlinable public init(shape: Content, style: Style, fillStyle: FillStyle = FillStyle())

	public typealias Body = Never
}

/// A storage type for a sheet presentation.
public struct Sheet {
	/// The content of the sheet.
	public var content: AnyView

	/// Indicates that the sheet should be presented as critical.
	///  - Note:  If the window already has a presented sheet, it will queue up
	/// sheets presented after that. Once the presented sheet is dismissed, the
	/// next queued sheet will be presented, and so forth. Critical sheets will
	/// skip this queuing process and be immediately presented on top of
	/// existing sheets. The presented sheet will be temporarily disabled and
	/// be able to be interacted with after the critical sheet is dismissed,
	/// and will then continue as normal. Critical sheets should only be used
	/// for time-critical or important events, when the presentation of the
	/// sheet needs to be guaranteed.
	public var isCritical: Bool

	/// Creates a sheet with custom content.
	public init<V>(content: V, isCritical: Bool = false) where V : View
}

/// A `ListStyle` that implements the system default sidebar list
/// (or source list) interaction and appearance.
public struct SidebarListStyle : ListStyle {
}

/// A container event handler that evaluates its two child gestures
/// simultaneously.
///
/// The phase of `SimultaneousGesture` is a combination of the phases
/// of children, representing the phase that most accurately describes
/// the entire group.
public struct SimultaneousGesture<First, Second> where First : Gesture, Second : Gesture {
	/// The type of value produced by this gesture.
	public struct Value {
		public var first: First.Value?

		public var second: Second.Value?
	}
	public var first: First
	public var second: Second

	/// Creates an instance from two child gestures.
	@inlinable public init(_ first: First, _ second: Second)

	public typealias Body = Never
}

extension SimultaneousGesture : Gesture {
}

extension SimultaneousGesture.Value : Equatable where First.Value : Equatable, Second.Value : Equatable {
}

extension SimultaneousGesture.Value : Hashable where First.Value : Hashable, Second.Value : Hashable {}

/// A shape wrapper that gives the shape a fixed size to resolve itself
/// against. This does not affect the layout properties of any views
/// created from the shape (e.g. by filling it).
public struct SizedShape<S> : Shape where S : Shape {
	public var shape: S
	public var size: CGSize

	@inlinable public init(shape: S, size: CGSize)

	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in rect: CGRect) -> Path

	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<S.AnimatableData, CGSize.AnimatableData>

	/// The data to be animated.
	public var animatableData: AnimatablePair<S.AnimatableData, CGSize.AnimatableData>

	public typealias Body = ShapeView<SizedShape<S>, ForegroundStyle>
}

/// A control for selecting a value from a bounded linear range of values.
///
/// The appearance and interaction of `Slider` is determined at runtime and can
/// be customized. `Slider` uses the `SliderStyle` provided by its environment
/// to define its appearance and interaction. Each platform provides a default
/// style that reflects the platform style, but providing a new style will
/// redefine all `Slider` instances within that environment.
///
/// - SeeAlso: `SliderStyle`
public struct Slider {
	public var body: _View { get }

	public typealias Body
}

extension Slider {
	/// Creates an instance that selects a value in the range
	/// `minValue...maxValue`.
	///  - Parameters:
	///     - value: The selected value within `minValue...maxValue`. The
	///       `value` of the created instance will be equal to the position of
	///       the given value within `minValue...maxValue` mapped into `0...1`.
	/// 	- minValue: The beginning of the range of the valid values. Defaults
	///       to `0.0`
	/// 	- maxValue: The end of the range of valid values. Defaults to `1.0`.
	public init<V>(value: Binding<V>, from minValue: V = 0.0, through maxValue: V = 1.0, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint

	/// Creates an instance that selects a value in the range
	/// `minValue...maxValue`.
	///  - Parameters:
	///     - value: The selected value within `minValue...maxValue`. The
	///       `value` of the created instance will be equal to the position of
	///       the given value within `minValue...maxValue` mapped into `0...1`.
	/// 	- minValue: The beginning of the range of the valid values.
	/// 	- maxValue: The end of the range of valid values. `maxValue` is a
	///       valid value if and only if it can be produced from `minValue`
	///       using multiples of `stride`.
	/// 	- stride: The distance between each valid value. A positive `stride`
	///       moves upward; a negative `stride` moves downward. `stride` is
	///       required to move towards `maxValue`.
	public init<V>(value: Binding<V>, from minValue: V, through maxValue: V, by stride: V.Stride, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint
}

/// A flexible space that expands along the major axis of its containing stack
/// layout, or on both axes if not contained in a stack.
public struct Spacer {
	/// The minimum length this spacer can be shrunk to, along the axis or axes
	/// of expansion.
	///  If `nil`, the system default spacing between views is used.
	public var minLength: Length?

	@inlinable public init(minLength: Length? = nil)

	public typealias Body = Never
}

extension Spacer : View {
}

public struct SquareBorderTextFieldStyle : TextFieldStyle {
}

/// A linked View property that instantiates a persistent state
/// value of type `Value`, allowing the view to read and update its
/// value.
@propertyDelegate public struct State<Value> : DynamicViewProperty, BindingConvertible {
	/// Initialize with the provided initial value.
	public init(initialValue value: Value)

	/// The current state value.
	public var value: Value { get nonmutating set }

	/// Returns a binding referencing the state value.
	public var binding: Binding<Value> { get }

	/// Produces the binding referencing this state value
	public var delegateValue: Binding<Value> { get }

	/// Produces the binding referencing this state value
	/// TODO: old name for storageValue, to be removed
	public var storageValue: Binding<Value> { get }
}

extension State where Value : ExpressibleByNilLiteral {
	/// Initialize with a nil initial value.
	@inlinable public init()
}

/// A concrete wrapper for enabling implicit member expressions (a.k.a. "leading
/// dot syntax").
///
/// `StaticMember` can be used to support implicit member expressions where they
/// would normally not be supported, such as static properties representing
/// concrete values provided to a protocol-constrained generic function.
///
/// For example:
///
///     protocol ColorStyle {
///         typealias Member = StaticMember<Self>
///     }
///
///     extension StaticMember where Base : ColorStyle {
///         static var red: RedStyle.Member { return .init(.init()) }
///         static var blue: BlueStyle.Member { return .init(.init()) }
///     }
///
///     extension View {
///         func colorStyle<S : ColorStyle>(_ style: S.Member) -> some View {
///             ...
///         }
///     }
///
///     MyView().colorStyle(.red)
///     MyView().colorStyle(.blue)
///
public struct StaticMember<Base> {
	public var base: Base

	/// Creates an instance representing `base`.
	public init(_ base: Base)
}

extension StaticMember where Base : ToggleStyle {
	/// The default `ToggleStyle`.
		public static var `default`: DefaultToggleStyle.Member { get }
}

extension StaticMember where Base : ListStyle {
	/// A `ListStyle` that implements the system default sidebar list
	/// (or source list) interaction and appearance.
	public static var sidebar: SidebarListStyle.Member { get }
}

extension StaticMember where Base : PickerStyle {
	/// A `PickerStyle` where the options are disclosed from a button that
	/// presents them in a menu, and the button itself indicates the selected
	/// option.
	///  This style is also appropriate for including auxiliary controls in the
	/// set of options, such as a customization button to customize the list
	/// of options.
		public static var popUpButton: _PopUpButtonPickerStyle.Member { get }
}

extension StaticMember where Base : DatePickerStyle {
	/// The default `DatePicker` style.
	public static var `default`: DefaultDatePickerStyle.Member { get }
}

extension StaticMember where Base : DatePickerStyle {
	/// A system style that displays the components in an editable field, with
	/// adjoining stepper that can increment/decrement the selected component.
	///  This style is useful when space is constrained and users expect to
	/// make specific date and time selections.
	public static var stepperField: StepperFieldDatePickerStyle.Member { get }

	/// A system style that displays the components in an editable field.
	///  This style is useful when space is constrained and users expect to
	/// make specific date and time selections. `stepperField` should be
	/// preferred over this style unless the use case requires hiding the
	/// stepper.
	public static var field: FieldDatePickerStyle.Member { get }

	/// A system style of `DatePicker` that displays an interactive calendar or
	/// clock.
	///  This style is useful when wanting to allow browsing through days in a
	/// calendar, or when the look of a clock face is appropriate.
	public static var graphical: GraphicalDatePickerStyle.Member { get }
}

extension StaticMember where Base : ListStyle {
	/// A `ListStyle` that implements the system default `List` interaction
	/// and appearance.
	///  The default appearance is `.plain`.
	public static var plain: PlainListStyle.Member { get }
}

extension StaticMember where Base : ListStyle {
}

extension StaticMember where Base : TextFieldStyle {
	/// A `TextField` style with no decoration.
	public static var plain: PlainTextFieldStyle.Member { get }
}

extension StaticMember where Base : PickerStyle {
}

extension StaticMember where Base : ToggleStyle {
	/// A `ToggleStyle` represented by a trailing switch.
	public static var `switch`: SwitchToggleStyle.Member { get }
}

extension StaticMember where Base : ShapeStyle {
	/// A style appropriate for foreground separator or border lines.
	public static var separator: SeparatorShapeStyle.Member { get }
}

extension StaticMember where Base : ShapeStyle {
	/// A style usable as the backgrounds for selected elements.
	///  - Parameter isSelected: Whether or not the associated view is selected.
	///   Passing `false` results in the style being equivalent to clear.
	///   Defaults to `true`.
	///  For example:
	/// 	ForEach(items.identified(by: \.id)) {
	///        ItemView(item)
	///           .padding()
	///           .background(.selection(item.id == selectedID))
	///     }
	///  On macOS this automatically reflects window key state and focus state,
	/// where the emphasized appearance will be used only when the window is
	/// key and the nearest focusable element is actually focused.
	public static func selection(_ isSelected: Bool = true) -> SelectionShapeStyle.Member
}

extension StaticMember where Base : TextFieldStyle {
	/// A `TextField` style with a system-defined square border.
	public static var squareBorder: SquareBorderTextFieldStyle.Member { get }
}

extension StaticMember where Base : TextFieldStyle {
	/// A `TextField` style with a system-defined rounded border.
	public static var roundedBorder: RoundedBorderTextFieldStyle.Member { get }
}

extension StaticMember where Base : ListStyle {
	/// The default `List` style.
	public static var `default`: DefaultListStyle.Member { get }
}

extension StaticMember where Base : PickerStyle {
	/// The default `Picker` style.
	public static var `default`: _DefaultPickerStyle.Member { get }
}

extension StaticMember where Base : PickerStyle {
	/// A `PickerStyle` where each option is represented as a radio button
	/// in a group of all options.
	///  This style is appropriate when there are two to five options. Consider
	/// the `popUpButton` style when there are more.
	///  Generally, use sentence-style capitalization without ending punctuation
	/// as the label for each option.
		public static var radioGroup: _RadioGroupPickerStyle.Member { get }
}

/// A control used to perform semantic increment and decrement actions.
///
/// The appearance and interaction of `Stepper` is determined at runtime and can
/// be customized. `Stepper` uses the `StepperStyle` provided by its environment
/// to define its appearance and interaction. Each platform provides a default
/// style that reflects the platform style, but providing a new style will
/// redefine all `Stepper` instances within that environment.
///
/// - SeeAlso: `StepperStyle`
public struct Stepper<Label> where Label : View {
	public init(onIncrement: (() -> Void)?, onDecrement: (() -> Void)?, onEditingChanged: @escaping (Bool) -> Void = { _ in }, label: () -> Label)
	public var body: _View { get }

	public typealias Body
}

extension Stepper {
	/// Creates an instance configured to increment and decrement `value` by
	/// units of `step`.
	public init<V>(value: Binding<V>, step: V.Stride = 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }, label: () -> Label) where V : Strideable

	/// Creates an instance configured to increment and decrement `value` by
	/// units of `step` and clamped to `bounds`.
	///  `onIncrement` will be initialized to `nil` if attempting to increment
	/// `value` will have no effect. Likewise, `onDecrement` will be initialized
	/// to `nil` if attempting to decrement `value` will have no effect.
	public init<V>(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }, label: () -> Label) where V : Strideable
}

public struct StepperFieldDatePickerStyle : DatePickerStyle {
	/// Returns the appearance and interaction content for a `DatePicker`.
	public func body(configuration: DatePicker<StepperFieldDatePickerStyle.Label>) -> StepperFieldDatePickerStyle.Body

	/// A view representing the appearance and interaction of a `DatePicker`.
	public struct Body {
		public var body: _View { get }
		public typealias Body
	}
}

public struct StrokeStyle : Equatable {
	public var lineWidth: Length
	public var lineCap: CGLineCap
	public var lineJoin: CGLineJoin
	public var miterLimit: Length
	public var dash: [Length]
	public var dashPhase: Length
	public init(lineWidth: Length = 1, lineCap: CGLineCap = .butt, lineJoin: CGLineJoin = .miter, miterLimit: Length = 10, dash: [Length] = [Length](), dashPhase: Length = 0)
}

extension StrokeStyle : Animatable {
	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<Length, AnimatablePair<Length, Length>>

	/// The data to be animated.
	public var animatableData: StrokeStyle.AnimatableData
}

/// An absolute shape that has been stroked.
public struct StrokedShape<S> : Shape where S : Shape {
	/// The source shape.
	public var shape: S

	/// The stroke style.
	public var style: StrokeStyle

	@inlinable public init(shape: S, style: StrokeStyle)

	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in rect: CGRect) -> Path

	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<S.AnimatableData, StrokeStyle.AnimatableData>

	/// The data to be animated.
	public var animatableData: AnimatablePair<S.AnimatableData, StrokeStyle.AnimatableData>

	public typealias Body = ShapeView<StrokedShape<S>, ForegroundStyle>
}

/// A view that subscribes to a `Publisher` with an `Action`
public struct SubscriptionView<PublisherType, Content> where PublisherType : Publisher, Content : View, PublisherType.Failure == Never {
	public typealias Body = Never
}

public struct SwitchToggleStyle : ToggleStyle {
	/// Returns the appearance and interaction content for a `Toggle`.
	///  All styles are expected to display the `content` of `toggle` in
	/// some way, visually indicate whether or not `toggle` is "on" or "off",
	/// and provide an interaction mechanism for toggling it.
	public func body(configuration: Toggle<SwitchToggleStyle.Label>) -> SwitchToggleStyle.Body

	/// A view representing the appearance and interaction of a `Toggle`.
	public struct Body {
		public var body: _View { get }
		public typealias Body
	}
}

/// A view which allows for switching between multiple child views using
/// interactable user interface elements.
///
/// `TabbedView` only supports tab items of type `Text`, `Image`, or a
/// `LayoutView` of `Image` and `Text`. Passing any other type of view will
/// result in a visible, empty tab item.
public struct TabbedView<SelectionValue, Content> where SelectionValue : Hashable, Content : View {
	/// Creates an instance that selects from content associated with
	/// `Selection` values.
	public init(selection: Binding<SelectionValue>, content: () -> Content)

	public typealias Body = Never
}

extension TabbedView where SelectionValue == Int {
	public init(content: () -> Content)
}

/// A gesture that ends once a specified number of tap event sequences
/// have been recognized.
public struct TapGesture {
	/// The required number of tap events.
	public var count: Int
	public init(count: Int = 1)

	/// The type of value produced by this gesture.
	public typealias Value = ()

	public typealias Body = Never
}

extension TapGesture : Gesture {
}

/// A view that displays one or more lines of read-only text.
public struct Text : Equatable {
	/// Creates an instance that displays `content` verbatim.
	public init(verbatim content: String)

	/// Creates an instance that displays `content` verbatim.
	public init<S>(_ content: S) where S : StringProtocol

	/// Creates text that displays localized content identified by a key.
	///  - Parameters:
	///     - key: The key for a string in the table identified by `tableName`.
	///     - tableName: The name of the string table to search. If `nil`, uses
	///       the table in `Localizable.strings`.
	///     - bundle: The bundle containing the strings file. If `nil`, uses the
	///       main `Bundle`.
	///     - comment: Contextual information about this key-value pair.
	public init(_ key: LocalizedStringKey, tableName: String? = nil, bundle: Bundle? = nil, comment: StaticString? = nil)
	public func resolve(into result: inout Text._Resolved, in environment: EnvironmentValues)
}

extension Text {
	/// Sets the color of this text.
	///  - Parameter color: The color to use when displaying this text.
	/// - Returns: Text that uses the color value you supply.
	public func color(_ color: Color?) -> Text

	/// Sets the font to use when displaying this text.
	///  - Parameter font: The font to use when displaying this text.
	/// - Returns: Text that uses the font you specify.
	public func font(_ font: Font?) -> Text

	/// Sets the font weight of this text.
	///  - Parameter weight: One of the available font weights.
	/// - Returns: Text that uses the font weight you specify.
	public func fontWeight(_ weight: Font.Weight?) -> Text

	/// Applies a bold font weight to this text.
	///  - Returns: Bold text.
	public func bold() -> Text

	/// Applies italics to this text.
	///  - Returns: Italic text.
	public func italic() -> Text

	/// Applies a strikethrough to this text.
	///  - Parameters:
	///   - active: A Boolean value that indicates whether the text has a
	///     strikethrough applied.
	///   - color: The color of the strikethrough. If `color` is `nil`, the
	///     strikethrough uses the default foreground color.
	/// - Returns: Text with a line through its center.
	public func strikethrough(_ active: Bool = true, color: Color? = nil) -> Text

	/// Applies an underline to this text.
	///  - Parameters:
	///   - active: A Boolean value that indicates whether the text has an
	///     underline.
	///   - color: The color of the underline. If `color` is `nil`, the
	///     underline uses the default foreground color.
	/// - Returns: Text with a line running along its baseline.
	public func underline(_ active: Bool = true, color: Color? = nil) -> Text

	/// Sets the tracking for this text.
	///  - Parameter kerning: The amount of spacing to use between individual
	///   characters in this text.
	/// - Returns: Text with the specified amount of tracking.
	public func kerning(_ kerning: Length) -> Text

	/// Sets the baseline offset for this text.
	///  - Parameter baselineOffset: The amount to shift the text vertically
	///   (up or down) in relation to its baseline.
	/// - Returns: Text that's above or below its baseline.
	public func baselineOffset(_ baselineOffset: Length) -> Text
}

extension Text {
	public static func + (lhs: Text, rhs: Text) -> Text
}

extension Text {
	/// How text is truncated when a line of text is too long to fit into the
	/// available space.
	public enum TruncationMode {
		case head

		case tail

		case middle

	}
}

extension Text {
	public typealias Body = Never
}

/// A control that displays an editable text interface.
///
/// The appearance and interaction of `TextField` is determined at runtime and
/// can be customized. `TextField` uses the `TextFieldStyle` provided by its
/// environment to define its appearance and interaction. Each platform provides
/// a default style that reflects the platform style, but providing a new style
/// will redefine all `TextField` instances within that environment.
///
/// - SeeAlso: `TextFieldStyle`
public struct TextField {
	public init(_ text: Binding<String>, placeholder: Text? = nil, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {})

	/// Create an instance which binds over an arbitrary type, `T`.
	///  - Parameters:
	///   - binding: The underlying value to be edited.
	///   - placeholder: The text that is displayed when `text` is empty. If
	///     `nil`, then no placeholder will be shown.
	///   - formatter: The `Formatter` to use when converting between the
	///     `String` the user edits and the underlying value of type `T`.
	///     In the event that `formatter` is unable to perform the conversion,
	///     `binding.value` will not be modified.
	///   - onEditingChanged: An `Action` that will be called when the user
	///     begins editing `text` and after the user finishes editing `text`,
	///     passing a `Bool` indicating whether `self` is currently being edited
	///     or not.
	///   - onCommit: The action to perform when the user performs an action
	///     (usually the return key) while the `TextField` has focus.
	public init<T>(_ binding: Binding<T>, placeholder: Text? = nil, formatter: Formatter, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {})
	public var body: _View { get }

	public typealias Body
}

/// A specification for the appearance and interaction of a `TextField`.
public protocol TextFieldStyle {
}

extension TextFieldStyle {
	public typealias Member = StaticMember<Self>
}

public struct TextFieldStyleModifier<Style> where Style : TextFieldStyle {
	/// The type of view representing the body of `Self`.
	public typealias Body = Never
}

extension TextFieldStyleModifier : ViewModifier {
}

/// A control that toggles between "on" and "off" states.
///
/// The appearance and interaction of `Toggle` is determined at runtime and can
/// be customized. `Toggle` uses the `ToggleStyle` provided by its environment
/// to define its appearance and interaction. Each platform provides a default
/// style that reflects the platform style, but providing a new style will
/// redefine all `Toggle` instances within that environment.
///
/// - SeeAlso: `ToggleStyle`
public struct Toggle<Label> where Label : View {
	/// Creates an instance that displays state based on `isOn`.
	///  - Parameters:
	///     - label: A view that describes the effect of selecting the toggle.
	///     - isOn: The state of the Toggle, either `on` or `off`.
	public init(isOn: Binding<Bool>, label: () -> Label)
	public var body: _View { get }

	public typealias Body
}

/// A specification for the appearance and interaction of a `Toggle`.
public protocol ToggleStyle {
	/// A view representing the appearance and interaction of a `Toggle`.
	associatedtype Body : View

	/// Returns the appearance and interaction content for a `Toggle`.
	///  All styles are expected to display the `content` of `toggle` in
	/// some way, visually indicate whether or not `toggle` is "on" or "off",
	/// and provide an interaction mechanism for toggling it.
	func body(configuration: Toggle<Self.Label>) -> Self.Body

	/// The type-erased `label` of the `Toggle` being defined.
	typealias Label = ToggleStyleLabel
}

extension ToggleStyle {
	public typealias Member = StaticMember<Self>
}

public struct ToggleStyleLabel : View {
	public typealias Body = Never
}

/// A model object that contains a `View` to be shown in the Touch Bar
public struct TouchBar<Content> where Content : View {
	/// Non-customizable `TouchBar`
	public init(content: () -> Content)

	/// Customizable `TouchBar`
	///  - Parameter id: A globally unique identifier for this TouchBar.
	public init(id: String, content: () -> Content)
}

public enum TouchBarItemPresence {
	/// Visible by default and cannot be removed during customization
	///  - Parameter id: A globally unique identifier for this item.
	case required(String)

	/// Visible by default, but can be removed during customization
	/// ///
	/// - Parameter id: A globally unique identifier for this item.
	case `default`(String)

	/// Not visible by default, but appears in the customization palette
	///  - Parameter id: A globally unique identifier for this item.
	case optional(String)
}

public struct Transaction {
	public init()
}

extension Transaction {
}

extension Transaction {
	/// True if the transaction was created by a "continuous" action,
	/// e.g. dragging a slider rather than tapping it once.
	public var isContinuous: Bool
}

extension Transaction {
	public init(animation: Animation?)
	public var animation: Animation?
	public var disablesAnimations: Bool
}

/// A shape with an affine transform translation applied to it.
public struct TransformedShape<S> : Shape where S : Shape {
	public var shape: S
	public var transform: CGAffineTransform

	@inlinable public init(shape: S, transform: CGAffineTransform)

	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in rect: CGRect) -> Path

	/// The type defining the data to be animated.
	public typealias AnimatableData = S.AnimatableData

	/// The data to be animated.
	public var animatableData: S.AnimatableData

	public typealias Body = ShapeView<TransformedShape<S>, ForegroundStyle>
}

/// An absolute shape that has been trimmed to a fractional section.
public struct TrimmedShape<S> : Shape where S : Shape {
	/// The source shape.
	public var shape: S

	/// The start point of the trimmed shape, as a fraction between
	/// zero and one.
	public var startFraction: CGFloat

	/// The end point of the trimmed shape, as a fraction between zero
	/// and one.
	public var endFraction: CGFloat

	@inlinable public init(shape: S, startFraction: CGFloat = 0, endFraction: CGFloat = 1)

	/// Describes this shape as a path within a rectangular frame of reference.
	///  - Parameter rect: The frame of reference for describing this shape.
	/// - Returns: A path that describes this shape.
	public func path(in rect: CGRect) -> Path

	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<S.AnimatableData, AnimatablePair<CGFloat, CGFloat>>

	/// The data to be animated.
	public var animatableData: AnimatablePair<S.AnimatableData, AnimatablePair<CGFloat, CGFloat>>

	public typealias Body = ShapeView<TrimmedShape<S>, ForegroundStyle>
}

/// A View created from a swift tuple of View values.
public struct TupleView<T> {
	public var value: T

	@inlinable public init(_ value: T)

	public typealias Body = Never
}

extension TupleView : View {
}

public struct UnitPoint : Hashable {
	public var x: CGFloat
	public var y: CGFloat

	@inlinable public init()
	@inlinable public init(x: CGFloat, y: CGFloat)
	
	public static let zero: UnitPoint
	public static let center: UnitPoint
	public static let leading: UnitPoint
	public static let trailing: UnitPoint
	public static let top: UnitPoint
	public static let bottom: UnitPoint
	public static let topLeading: UnitPoint
	public static let topTrailing: UnitPoint
	public static let bottomLeading: UnitPoint
	public static let bottomTrailing: UnitPoint
}

extension UnitPoint : Animatable {
	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<CGFloat, CGFloat>

	/// The data to be animated.
	public var animatableData: UnitPoint.AnimatableData
}

/// An alignment in the vertical axis.
public enum VAlignment {
	case top
	case center
	case bottom
}

/// A layout container that arranges its children in a vertical line
/// and allows the user to resize them using dividers placed between them.
public struct VSplitView<Content> where Content : View {
	public init(content: () -> Content)

	public typealias Body = Never
}

/// A view that arranges its children in a vertical line.
public struct VStack<Content> where Content : View {
	/// Creates an instance with the given `spacing` and Y axis `alignment`.
	///  - Parameters:
	///     - alignment: the guide that will have the same horizontal screen
	///       coordinate for all children.
	///     - spacing: the distance between adjacent children, or nil if the
	///       stack should choose a default distance for each pair of children.
	@inlinable public init(alignment: HorizontalAlignment = .center, spacing: Length? = nil, content: () -> Content)

	public typealias Body = Never
}

/// A type that may be used as the `AnimatableData` associated type of
/// a type conforming to the `Animatable` protocol. Extends the
/// `AdditiveArithmetic` protocol with scalar multiplication and a way
/// to query the vector magnitude of the value.
public protocol VectorArithmetic : AdditiveArithmetic {
	/// Multiplies each component of `self` by the scalar `rhs`.
	mutating func scale(by rhs: Double)

	/// Returns the dot-product of `self` with itself.
	var magnitudeSquared: Double { get }
}

/// An alignment position along the horizontal axis
public struct VerticalAlignment {
	/// Creates an instance with the given ID.
	///  Note: each instance should have a unique ID.
	public init(_ id: AlignmentID.Type)
}

extension VerticalAlignment {
	/// A guide marking the top edge of the view.
	public static let top: VerticalAlignment

	/// A guide marking the vertical center of the view.
	public static let center: VerticalAlignment

	/// A guide marking the bottom edge of the view.
	public static let bottom: VerticalAlignment

	/// A guide marking the topmost text baseline view.
	public static let firstTextBaseline: VerticalAlignment

	/// A guide marking the bottom-most text baseline in a view.
	public static let lastTextBaseline: VerticalAlignment
}

extension VerticalAlignment : Equatable {
}

/// A piece of user interface.
///
/// You create custom views by declaring types that conform to the `View`
/// protocol. Implement the required `body` property to provide the content
/// and behavior for your custom view.
public protocol View : _View {
	/// The type of view representing the body of this view.
	///  When you create a custom view, Swift infers this type from your
	/// implementation of the required `body` property.
	associatedtype Body : View

	/// Declares the content and behavior of this view.
	var body: Self.Body { get }
}

extension View {
	/// Adds a condition for whether the view hierarchy for `self` can be deleted.
	public func deleteDisabled(_ isDisabled: Bool) -> Self.Modified<_TraitWritingModifier<Bool>>
}

extension View {
	/// Applies the given transaction mutation function to all transactions
	/// used within the view.
	///  Use this modifier on leaf views rather than container views. The
	/// transformation applies to all child views within this view; calling
	/// `transaction(_:)` on a container view can lead to unbounded scope.
	///  - Parameter transform: The transformation to apply to transactions
	///   within this view.
	/// - Returns: A view that wraps this view and applies `transformation`
	///   to all transactions used within the view.
	public func transaction(_ transform: @escaping (inout Transaction) -> Void) -> Self.Modified<_TransactionModifier>

	/// Applies the given animation to all animatable values within this view.
	///  Use this modifier on leaf views rather than container views. The
	/// animation applies to all child views within this view; calling
	/// `animation(_:)` on a container view can lead to unbounded scope.
	///  - Parameter animation: The animation to apply to animatable values
	///   within this view.
	/// - Returns: A view that wraps this view and applies `animation`
	///   to all animatable values used within the view.
	public func animation(_ animation: Animation?) -> Self.Modified<_TransactionModifier>
}

extension View {
	@inlinable public func mask<Mask>(_ mask: Mask) -> Self.Modified<_MaskEffect<Mask>> where Mask : View
}

extension View {
	/// Returns a view wrapping `self` that sets a `value` for an environment
	/// `keyPath`.
	@inlinable public func environment<V>(_ keyPath: WritableKeyPath<EnvironmentValues, V>, _ value: V) -> Self.Modified<_EnvironmentKeyWritingModifier<V>>
}

extension View {
	/// Sets the style for `PopUpButton` within the environment of `self`.
	public func popUpButtonStyle(_ style: AnyPopUpButtonStyle) -> Self.Modified<_EnvironmentKeyWritingModifier<AnyPopUpButtonStyle>>
}

extension View {
	/// Adds an action to perform when the user moves the pointer over or away
	/// from this view's frame.
	///  Calling this method defines a region for detecting pointer movement
	/// with the size and position of this view.
	///  - Parameter action: The action to perform whenever the pointer enters or
	///   exits this view's frame. If the pointer is in the view's frame,
	///   the `action` closure passes `true` as a parameter; otherwise, `false`.
	/// - Returns: A view that triggers `action` when the pointer enters and
	///   exits this view's frame.
	public func onHover(perform action: @escaping (Bool) -> Void) -> Self.Modified<_HoverRegionModifier>
}

extension View {
	/// Sets the `TouchBar` and its content to be shown in the Touch Bar
	/// when applicable
	public func touchBar<Content>(_ touchBar: TouchBar<Content>) -> Self.Modified<_TouchBarModifier<Content>> where Content : View
}

extension View where Self : Equatable {
	/// Returns a new view that will prevent `self` updating its child
	/// view when its new value is the same as its old value.
	@inlinable public func equatable() -> EquatableView<Self>
}

extension View {
	/// Returns a version of `self` that will invoke `action` after
	/// recognizing a tap gesture.
	public func tapAction(count: Int = 1, _ action: @escaping () -> Void) -> _AutoResultView<Self>
}

extension View {
	/// Overrides the device for a preview.
	///  If `nil` (default), Xcode will automatically pick an appropriate device
	/// based on your target.
	///  The following values are supported:
	/// 	"Mac"
	///     "iPhone 7"
	///     "iPhone 7 Plus"
	///     "iPhone 8"
	///     "iPhone 8 Plus"
	///     "iPhone SE"
	///     "iPhone X"
	///     "iPhone Xs"
	///     "iPhone Xs Max"
	///     "iPhone Xʀ"
	///     "iPad mini 4"
	///     "iPad Air 2"
	///     "iPad Pro (9.7-inch)"
	///     "iPad Pro (12.9-inch)"
	///     "iPad (5th generation)"
	///     "iPad Pro (12.9-inch) (2nd generation)"
	///     "iPad Pro (10.5-inch)"
	///     "iPad (6th generation)"
	///     "iPad Pro (11-inch)"
	///     "iPad Pro (12.9-inch) (3rd generation)"
	///     "iPad mini (5th generation)"
	///     "iPad Air (3rd generation)"
	///     "Apple TV"
	///     "Apple TV 4K"
	///     "Apple TV 4K (at 1080p)"
	///     "Apple Watch Series 2 - 38mm"
	///     "Apple Watch Series 2 - 42mm"
	///     "Apple Watch Series 3 - 38mm"
	///     "Apple Watch Series 3 - 42mm"
	///     "Apple Watch Series 4 - 40mm"
	///     "Apple Watch Series 4 - 44mm"
	public func previewDevice(_ value: PreviewDevice?) -> Self.Modified<_TraitWritingModifier<PreviewDevice?>>

	/// Overrides the size of the container for the preview.
	///  Default is `.device`.
	public func previewLayout(_ value: PreviewLayout) -> Self.Modified<_TraitWritingModifier<PreviewLayout>>

	/// Provides a user visible name shown in the editor.
	///  Default is `nil`.
	public func previewDisplayName(_ value: String?) -> Self.Modified<_TraitWritingModifier<String?>>
}

extension View {
	/// Sets up an action that triggers in response to the given command.
	///  This view or one of the views it contains must be in focus in order
	/// for the action to trigger. Other actions for the same command
	/// on views *closer* to the view in focus take priority, potentially
	/// overriding this action.
	///  - Parameters:
	///   - command: The command to register for `action`.
	///   - action: The action to perform. If `action` is `nil`, `command`
	///     keeps its association with this view but doesn't trigger.
	/// - Returns: A view that triggers `action` when the `command` occurs.
	public func onCommand(_ command: Command, perform action: (() -> Void)?) -> _AutoViewWrapper

	/// Sets up an action that triggers in response to the system paste command.
	///  Pass an array of uniform type identifiers to the `supportedTypes`
	/// parameter. Place the higher priority types closer to the beginning of the
	/// array. The pasteboard items that the `action` closure receives have the
	/// most preferred type out of all the types the source supports.
	///  For example, if your app can handle plain text and rich text, but you
	/// prefer rich text, place the rich text type first in the array. If rich
	/// text is available when the paste action occurs, the `action` closure
	/// passes that rich text along.
	///  - Parameters:
	///   - supportedTypes: The uniform type identifiers that describe the
	///     types of content this view can accept through a paste action.
	///     If the pasteboard doesn't contain any of the supported types, the
	///     paste command doesn't trigger.
	///   - action: The action to perform when the paste command triggers. The
	///     action closure's parameter contains items from the pasteboard
	///     with the types you specify in the `supportedTypes` parameter.
	/// - Returns: A view that triggers `action` when a system paste command
	///   occurs.
	public func onPaste(of supportedTypes: [String], perform action: @escaping ([NSItemProvider]) -> Void) -> _AutoViewWrapper

	/// Sets up an action that triggers in response to the system paste command
	/// that you validate with the given closure.
	///  Pass an array of uniform type identifiers to the `supportedTypes`
	/// parameter. Place the higher priority types closer to the beginning of the
	/// array. The pasteboard items that the `validator` closure receives have the
	/// most preferred type out of all the types the source supports.
	///  For example, if your app can handle plain text and rich text, but you
	/// prefer rich text, place the rich text type first in the array. If rich
	/// text is available when the paste action occurs, the `validator` closure
	/// passes that rich text along.
	///  - Parameters:
	///   - supportedTypes: The uniform type identifiers that describe the
	///     types of content this view can accept through a paste action.
	///     If the pasteboard doesn't contain any of the supported types, the
	///     paste command doesn't trigger.
	///   - validator: A handler that validates the command. This handler
	///     receives items from the pasteboard with the types you specify in the
	///    `supportedTypes` parameter. Use this handler to decide whether
	///     the items are valid and preprocess them for the `action` closure.
	///     If you return `nil` instead, the paste command doesn't trigger.
	///   - action: The action to perform when the paste command triggers.
	/// - Returns: A view that triggers `action` when the system paste command
	///   is invoked, validating the paste command with `validator`.
	public func onPaste<Payload>(of supportedTypes: [String], validator: @escaping ([NSItemProvider]) -> Payload?, perform action: @escaping (Payload) -> Void) -> _AutoViewWrapper
}

extension View {
	/// Activates this view as the source of a drag and drop operation.
	///  Applying the `onDrag(_:)` modifier adds the appropriate gestures for
	/// drag and drop to this view. When a drag operation begins,
	/// a rendering of this view is generated and used as the preview image.
	///  - Parameter data: A closure that returns a single `NSItemProvider` that
	///   represents the draggable data from this view.
	/// - Returns: A view that activates this view as the source of a drag
	///   and drop operation, beginning with user gesture input.
	public func onDrag(_ data: @escaping () -> NSItemProvider) -> Self.Modified<_DraggingModifier>
}

extension View {
	/// Returns a uniquely identified view that can be inserted or
	/// removed.
	@inlinable public func id<ID>(_ id: ID) -> IDView<Self, ID> where ID : Hashable
}

extension View {
	/// Adds an action to perform when the specified preference key's value
	/// changes.
	///  - Parameters:
	///   - key: The key to monitor for value changes.
	///   - action: The action to perform when the value for `key` changes. The
	///     `action` closure passes the new value as its parameter.
	/// - Returns: A view that triggers `action` when the value for `key`
	///   changes.
	@inlinable public func onPreferenceChange<K>(_ key: K.Type = K.self, perform action: @escaping (K.Value) -> Void) -> Self.Modified<_PreferenceActionModifier<K>> where K : PreferenceKey, K.Value : Equatable
}

extension View {
	@inlinable public func allowsHitTesting(_ enabled: Bool) -> Self.Modified<_AllowsHitTestingModifier>
}

extension View {
	/// Presents an alert to the user.
	///  - Parameters:
	///     - data: A Binding to some data. When representing non-nil data,
	///     the system uses `alert` to create an alert representation of the
	///     data.
	///     - id: A KeyPath that uniquely identifies the alert. If the identity
	///     changes, the system will dismiss a currently-presented alert and
	///     replace it by a new alert presentation.
	///     - alert: A closure returning the alert to present.
	public func presentation<T, ID>(_ data: Binding<T?>, id: KeyPath<T, ID>, alert: (T) -> Alert) -> _AutoResultView<Self> where ID : Hashable

	/// Presents an alert to the user.
	///  - Parameters:
	///     - isShown: A Binding to whether the alert should be shown.
	///     - alert: A closure returning the alert to present.
	public func presentation(_ isShown: Binding<Bool>, alert: () -> Alert) -> _AutoResultView<Self>
}

extension View {
	/// Attaches `gesture` to `self` such that it has lower precedence
	/// than gestures defined by `self`.
	public func gesture<T>(_ gesture: T, including mask: GestureMask = .all) -> _AutoResultView<Self> where T : Gesture

	/// Attaches `gesture` to `self` such that it has higher precedence
	/// than gestures defined by `self`.
	public func highPriorityGesture<T>(_ gesture: T, including mask: GestureMask = .all) -> _AutoResultView<Self> where T : Gesture

	/// Attaches `gesture` to self such that it will be processed
	/// simultaneously with gestures defined by `self`.
	public func simultaneousGesture<T>(_ gesture: T, including mask: GestureMask = .all) -> _AutoResultView<Self> where T : Gesture
}

extension View {
	@inlinable public func projectionEffect(_ transform: ProjectionTransform) -> Self.Modified<_ProjectionEffect>
}

extension View {
	@inlinable public func background<Background>(_ background: Background, alignment: Alignment = .center) -> Self.Modified<_BackgroundModifier<Background>> where Background : View

	@inlinable public func background<S>(_ content: S, cornerRadius: Length) -> Self.Modified<_BackgroundModifier<RoundedRectangle.Filled<S>>> where S : ShapeStyle

	@inlinable public func background<S>(_ content: S.Member, cornerRadius: Length) -> Self.Modified<_BackgroundModifier<RoundedRectangle.Filled<S>>> where S : ShapeStyle

	@inlinable public func background<S>(_ content: S.Member) -> Self.Modified<_BackgroundModifier<Rectangle.Filled<S>>> where S : ShapeStyle
}

extension View {
	/// The type resulting from applying a view modifier `T`.
	public typealias Modified<T>

	/// Returns a new view representing `self` with `modifier` applied
	/// to it.
	@inlinable public func modifier<T>(_ modifier: T) -> Self.Modified<T> where T : ViewModifier
}

extension View {
	/// Layers a secondary view in front of this view.
	///  When you apply an overlay to a view, the original view continues to
	/// provide the layout characteristics for the resulting view. For example,
	/// the layout for the caption in this view fits within the width of the
	/// image:
	/// 	Image(name: "artichokes")
	///         .overlay(
	///             HStack {
	///                 Text("Artichokes"), // Text to use as a caption.
	///                 Spacer()
	///             }
	///             .padding()
	///             .foregroundColor(.white)
	///             .background(Color.black.opacity(0.5)),
	/// 	        alignment: .bottom
	///         )
	///  **Image: overlay**
	///  - Parameters:
	///   - overlay: The view to layer in front of this view.
	///   - alignment: The alignment for `overlay` in relation to this view.
	/// - Returns: A view that layers `overlay` in front of this view.
	@inlinable public func overlay<Overlay>(_ overlay: Overlay, alignment: Alignment = .center) -> Self.Modified<_OverlayModifier<Overlay>> where Overlay : View

	/// Adds a border to this view with the specified style and width.
	///  By default, the border appears inside the bounds of this view. In this
	/// example, the four-point border covers the text:
	/// 	Text("Artichokes")
	///     .font(.title)
	///     .border(Color.green, width: 4)
	///  **Image: border**
	///  To place a border around the outside of this view, apply padding of the
	/// same width before adding the border:
	/// 	Text("Artichokes")
	///     .font(.title)
	///     .padding(4)
	///     .border(Color.green, width: 4)
	///  **Image: border_padding**
	///  - Parameters:
	///   - content: The border style.
	///   - width: The thickness of the border.
	/// - Returns: A view that adds a border with the specified style and width
	///   to this view.
	@inlinable public func border<S>(_ content: S, width: Length = 1) -> Self.Modified<_OverlayModifier<Rectangle.InsetShape.Stroked.Filled<S>>> where S : ShapeStyle

	/// Adds a border to this view with the given style, width, and corner
	/// radius.
	///  The border appears inside the bounds of this view, and doesn't hide
	/// the visible area that extends beyond the border's corners:
	/// 	Image(name: "artichokes")
	///     .border(Color.black, width: 10, cornerRadius: 20)
	///  **Image: border_cornerRadius**
	///  To hide the visible area beyond the border's corners, you can also
	/// apply a corner radius to the view itself:
	/// 	Image(name: "artichokes")
	///     .border(Color.black, width: 10, cornerRadius: 20)
	///     .cornerRadius(20)
	///  **Image: border_cornerRadius_clipShape**
	///  - Parameters:
	///   - content: The border style.
	///   - width: The thickness of the border.
	///   - cornerRadius: The corner radius of the border.
	/// - Returns: A view that adds a border with the specified style, width,
	///   and corner radius to this view.
	@inlinable public func border<S>(_ content: S, width: Length = 1, cornerRadius: Length) -> Self.Modified<_OverlayModifier<RoundedRectangle.InsetShape.Stroked.Filled<S>>> where S : ShapeStyle
}

extension View {
	/// Adds a condition for whether the view hierarchy for `self` can be moved.
	public func moveDisabled(_ isDisabled: Bool) -> Self.Modified<_TraitWritingModifier<Bool>>
}

extension View {
	/// Sets whether this view is focusable and, if so, adds an action to
	/// perform when the view comes into focus.
	///  - Parameters:
	///   - isFocusable: A Boolean value that indicates whether this view
	///     is focusable.
	///   - onFocusChange: A closure that's called whenever this view either
	///     gains or loses focus. The Boolean parameter to `onFocusChange` is
	///     `true` when the view is in focus; otherwise, it's `false`.
	/// - Returns: A view that sets whether a view is focusable, and triggers
	///   `onFocusChange` when the view gains or loses focus.
	public func focusable(_ isFocusable: Bool, onFocusChange: @escaping (Bool) -> Void = { _ in }) -> Self.Modified<_FocusableModifier>
}

extension View {
	/// Defines the destination for a drag and drop operation, using the same
	/// size and position as this view, handling dropped content with the given
	/// closure.
	///  - Parameters:
	///   - supportedTypes: The uniform type identifiers that describe the
	///     types of content this view can accept through drag and drop.
	///     If the drag and drop operation doesn't contain any of the supported
	///     types, then this drop destination doesn't activate and `isTargeted`
	///     doesn't update.
	///   - isTargeted: A binding that updates when a drag and drop operation
	///     enters or exits the drop target area. The binding's value is `true`
	///     when the cursor is inside the area, and `false` when the cursor is
	///     outside.
	///   - action: A closure that takes the dropped content and responds
	///     appropriately. The parameter to `action` contains the dropped
	///     items, with types specified by `supportedTypes`. Return `true`
	///     if the drop operation was successful; otherwise, return `false`.
	/// - Returns: A view that provides a drop destination for a drag
	///   operation of the specified types.
	public func onDrop(of supportedTypes: [String], isTargeted: Binding<Bool>?, perform action: @escaping ([NSItemProvider]) -> Bool) -> Self.Modified<_DropModifier>

	/// Defines the destination for a drag and drop operation with the same size
	/// and position as this view, handling dropped content and the drop
	/// location with the given closure.
	///  - Parameters:
	///   - supportedTypes: The uniform type identifiers that describe the
	///     types of content this view can accept through drag and drop.
	///     If the drag and drop operation doesn't contain any of the supported
	///     types, then this drop destination doesn't activate and `isTargeted`
	///     doesn't update.
	///   - isTargeted: A binding that updates when a drag and drop operation
	///     enters or exits the drop target area. The binding's value is `true`
	///     when the cursor is inside the area, and `false` when the cursor is
	///     outside.
	///   - action: A closure that takes the dropped content and responds
	///     appropriately. The first parameter to `action` contains the dropped
	///     items, with types specified by `supportedTypes`. The second
	///     parameter contains the drop location in this view's coordinate
	///     space. Return `true` if the drop operation was successful;
	///     otherwise, return `false`.
	/// - Returns: A view that provides a drop destination for a drag
	///   operation of the specified types.
	public func onDrop(of supportedTypes: [String], isTargeted: Binding<Bool>?, perform action: @escaping ([NSItemProvider], CGPoint) -> Bool) -> Self.Modified<_DropModifier>

	/// Defines the destination for a drag and drop operation with the same size
	/// and position as this view, with behavior controlled by the given
	/// delegate.
	///  - Parameters:
	///   - supportedTypes: The uniform type identifiers that describe the
	///     types of content this view can accept through drag and drop.
	///     If the drag and drop operation doesn't contain any of the supported
	///     types, then this drop destination doesn't activate and `isTargeted`
	///     doesn't update.
	///   - delegate: A type that conforms to the `DropDelegate` protocol. You
	///     have comprehensive control over drop behavior when you use a
	///     delegate.
	/// - Returns: A view that provides a drop destination for a drag
	///   operation of the specified types.
	public func onDrop(of supportedTypes: [String], delegate: DropDelegate) -> Self.Modified<_DropModifier>
}

extension View {
	/// Sets the width of this view to the specified proportion of its
	/// parent's width.
	///  Pass the fractional amount of the parent's width that you want to use
	/// as `proportion`. For example, passing `0.75` results in resizing a view
	/// to three-quarters the width of its parent.
	/// 	Color.purple
	///      .relativeWidth(0.75)
	///      .frame(width: 200, height: 200)
	///      .border(Color.gray)
	///  The purple color is sized at three-quarters of the width of its parent,
	/// the 200 by 200 frame.
	///  **Image: relativeWidth**
	///  - Parameter proportion: The fraction of the parent's width to use for
	///   this view. `proportion` must be positive.
	/// - Returns: A view that sets the width of this view relative to its
	///   parent.
	@inlinable public func relativeWidth(_ proportion: Length) -> Self.Modified<_RelativeLayoutTraitsLayout>

	/// Sets the height of this view to the specified proportion of its
	/// parent's height.
	///  Pass the fractional amount of the parent's height that you want to use
	/// as `proportion`. For example, passing `0.75` results in resizing a view
	/// to three-quarters the height of its parent.
	/// 	Color.purple
	///     .relativeHeight(0.75)
	///     .frame(width: 200, height: 200)
	///     .border(Color.gray)
	///  The purple color is sized at three-quarters of the height of its parent,
	/// the 200 by 200 frame.
	///  **Image: relativeHeight**
	///  - Parameter proportion: The fraction of the parent's height to use for
	///   this view. `proportion` must be positive.
	/// - Returns: A view that sets the height of this view relative to its
	///   parent.
	@inlinable public func relativeHeight(_ proportion: Length) -> Self.Modified<_RelativeLayoutTraitsLayout>

	/// Sets the size of this view to the specified proportion of its parent's
	/// width and height.
	///  Pass the fractional amounts of the parent's width and height that you
	/// want to use as `width` and `height`. For example, passing `0.75` for
	/// both parameters results in resizing a view to three-quarters the width
	/// and height of its parent.
	/// 	Color.purple
	///     .relativeSize(width: 0.75, height: 0.75)
	///     .frame(width: 200, height: 200)
	///     .border(Color.gray)
	///  The purple color is sized at three-quarters of the width and height of
	/// its parent, the 200 by 200 frame.
	///  **Image: relativeSize**
	///  - Parameters:
	///   - width: The fraction of the parent's width to use for this view.
	///     The `width` must be positive.
	///   - height: The fraction of the parent's height to use for this view.
	///     The `height` must be positive.
	/// - Returns: A view that sets the size of this view relative to its
	///   parent.
	@inlinable public func relativeSize(width: Length, height: Length) -> Self.Modified<_RelativeLayoutTraitsLayout>
}

extension View {
	/// Constrains this view's dimensions to the specified aspect ratio.
	///  If this view is resizable, the resulting view will have `aspectRatio`
	/// as its aspect ratio. In this example, the purple ellipse has a 3:4
	/// width to height ratio, and scales to fit its frame:
	/// 	Ellipse()
	///     .fill(Color.purple)
	///     .aspectRatio(0.75, contentMode: .fit)
	///     .frame(width: 200, height: 200)
	///     .border(Color(white: 0.75))
	///  **Image: aspectRatio_length**
	///  - Parameters:
	///   - aspectRatio: The ratio of width to height to use for the resulting
	///     view. If `aspectRatio` is `nil`, the resulting view maintains this
	///     view's aspect ratio.
	///   - contentMode: A flag indicating whether this view should fit or
	///     fill the parent context.
	/// - Returns: A view that constrains this view's dimensions to
	///   `aspectRatio`, using `contentMode` as its scaling algorithm.
	@inlinable public func aspectRatio(_ aspectRatio: Length? = nil, contentMode: ContentMode) -> Self.Modified<_AspectRatioLayout>

	/// Constrains this view's dimensions to the aspect ratio of the given size.
	///  If this view is resizable, the resulting view uses `aspectRatio` as its
	/// own aspect ratio. In this example, the purple ellipse has a 3:4 width
	/// to height ratio, and scales to fill its frame:
	/// 	Ellipse()
	///     .fill(Color.purple)
	///     .aspectRatio(Size(width: 3, height: 4), contentMode: .fill)
	///     .frame(width: 200, height: 200)
	///     .border(Color(white: 0.75))
	///  **Image: aspectRatio_size**
	///  - Parameters:
	///   - aspectRatio: A size specifying the ratio of width to height to use
	///     for the resulting view.
	///   - contentMode: A flag indicating whether this view should fit or
	///     fill the parent context.
	/// - Returns: A view that constrains this view's dimensions to
	///   `aspectRatio`, using `contentMode` as its scaling algorithm.
	@inlinable public func aspectRatio(_ aspectRatio: CGSize, contentMode: ContentMode) -> Self.Modified<_AspectRatioLayout>

	/// Scales this view to fit its parent.
	///  This view's aspect ratio is maintained as the view scales. This
	/// method is equivalent to calling `aspectRatio(nil, contentMode: .fit)`.
	/// 	 Circle()
	///      .fill(Color.pink)
	///      .scaledToFit()
	///      .frame(width: 300, height: 150)
	///      .border(Color(white: 0.75))
	///  **Image: scaledToFit**
	///  - Returns: A view that scales this view to fit its parent,
	///   maintaining this view's aspect ratio.
	@inlinable public func scaledToFit() -> Self.Modified<_AspectRatioLayout>

	/// Scales this view to fill its parent.
	///  This view's aspect ratio is maintained as the view scales. This
	/// method is equivalent to calling `aspectRatio(nil, contentMode: .fill)`.
	/// 	Circle()
	///     .fill(Color.pink)
	///     .scaledToFill()
	///     .frame(width: 300, height: 150)
	///     .border(Color(white: 0.75))
	///  **Image: scaledToFill**
	///  - Returns: A view that scales this view to fit its parent,
	///   maintaining this view's aspect ratio.
	@inlinable public func scaledToFill() -> Self.Modified<_AspectRatioLayout>
}

extension View {
	/// Pads this view using the edge insets you specify.
	///  - Parameter insets: The edges to inset.
	/// - Returns: A view that pads this view using edge the insets you specify.
	@inlinable public func padding(_ insets: EdgeInsets) -> Self.Modified<_PaddingLayout>

	/// Pads this view using the edge insets you specify.
	///  The following example only pads the horizontal edge insets:
	/// 	List {
	///         Text("Item 1")
	///     }
	///     .padding([.horizontal])
	///  - Parameters:
	///     - edges: The set of edges along which to inset this view.
	///     - length: The amount to inset this view on each edge. If `nil`,
	///       the amount is the system default amount.
	/// - Returns: A view that pads this view using edge the insets you specify.
	@inlinable public func padding(_ edges: Edge.Set = .all, _ length: Length? = nil) -> Self.Modified<_PaddingLayout>

	/// Pads this view along all edge insets by the amount you specify.
	///  - Parameter length: The amount to inset this view on each edge.
	/// - Returns: A view that pads this view by the amount you specify.
	@inlinable public func padding(_ length: Length) -> Self.Modified<_PaddingLayout>
}

extension View {
	/// Offsets this view by the horizontal and vertical distances in the given
	/// size.
	///  The original dimensions of the view are considered to be unchanged by
	/// offsetting the contents. For example, the gray border drawn by this
	/// view surrounds the original position of the text:
	/// 	Text("Hello world!")
	///     .font(.title)
	///     .offset(CGSize(width: 50, height: 10))
	///     .border(Color.gray)
	///  **Image: offset**
	///  - Parameter size: The distance to offset this view.
	/// - Returns: A view that offsets this view by `size`.
	@inlinable public func offset(_ offset: CGSize) -> Self.Modified<_OffsetEffect>

	/// Offsets this view by the specified horizontal and vertical distances.
	///  The original dimensions of the view are considered to be unchanged by
	/// offsetting the contents. For example, the gray border drawn by this
	/// view surrounds the original position of the text:
	/// 	Text("Hello world!")
	///     .font(.title)
	///     .offset(x: 50, y: 10)
	///     .border(Color.gray)
	///  **Image: offset**
	///  - Parameters:
	///   - x: The horizontal distance to offset this view.
	///   - y: The vertical distance to offset this view.
	/// - Returns: A view that offsets this view by `x` and `y`.
	@inlinable public func offset(x: Length = 0, y: Length = 0) -> Self.Modified<_OffsetEffect>
}

extension View {
	/// Fixes the center of this view at the specified point in its parent's
	/// coordinate space.
	///  - Parameter position: The point at which to place the center of this
	///   view.
	/// - Returns: A view that fixes the center of this view at `position`.
	@inlinable public func position(_ position: CGPoint) -> Self.Modified<_PositionLayout>

	/// Fixes the center of this view at the specified coordinates in its
	/// parent's coordinate space.
	///  - Parameters:
	///   - x: The x-coordinate at which to place the center of this view.
	///   - y: The y-coordinate at which to place the center of this view.
	/// - Returns: A view that fixes the center of this view at
	///   `x` and `y`.
	@inlinable public func position(x: Length = 0, y: Length = 0) -> Self.Modified<_PositionLayout>
}

extension View {
	/// Returns a new view that defines the content shape for
	/// hit-testing `self` as `shape`. `eoFill` defines whether the
	/// shape is interpreted using the even-odd winding number rule or
	/// not.
	@inlinable public func contentShape<S>(_ shape: S, eoFill: Bool = false) -> Self.Modified<_ContentShapeModifier<S>> where S : Shape
}

extension View {
	@inlinable public func transformEffect(_ transform: CGAffineTransform) -> Self.Modified<_TransformEffect>
}

extension View {
	/// Adds a condition that controls whether users can interact with this
	/// view.
	///  The higher views in a view hierarchy can override the value you set on
	/// this view. In the following example, the button isn't interactive
	/// because the outer `disabled(_:)` modifier overrides the inner one:
	/// 	HStack {
	///         Button(Text("Press")) {}
	///         .disabled(false)
	///     }
	///     .disabled(true)
	///  - Parameter disabled: A Boolean value that determines whether users can
	///   interact with this view.
	/// - Returns: A view that controls whether users can interact with this
	///   view.
	public func disabled(_ disabled: Bool) -> Self.Modified<_EnvironmentKeyTransformModifier<Bool>>
}

extension View {
	/// Set the foreground color within `self`.
	public func foregroundColor(_ color: Color?) -> Self.Modified<_EnvironmentKeyWritingModifier<Color?>>
}

extension View {
	@inlinable public func rotationEffect(_ angle: Angle, anchor: UnitPoint = .center) -> Self.Modified<_RotationEffect>
}

extension View {
	@inlinable public func scaleEffect(_ scale: CGSize, anchor: UnitPoint = .center) -> Self.Modified<_ScaleEffect>

	@inlinable public func scaleEffect(_ s: Length, anchor: UnitPoint = .center) -> Self.Modified<_ScaleEffect>

	@inlinable public func scaleEffect(x: Length = 0.0, y: Length = 0.0, anchor: UnitPoint = .center) -> Self.Modified<_ScaleEffect>
}

extension View {
	/// Hides this view.
	///  Hidden views are invisible and can't receive or respond to interactions.
	///  Returns: A view that hides this view.
	public func hidden() -> Self.Modified<_HiddenModifier>
}

extension View {
	/// Applies a Gaussian blur to this view.
	///  The following shows two versions of the same image side by side; at left
	/// is the original, and at right is a duplicate with its blur radius set to
	/// 10:
	///  **Image: blur_radius_value_10**
	///  - Parameters:
	///   - radius: The radial size of the blur. A blur is more diffuse when its
	///     radius is large.
	///   - opaque: A Boolean value that indicates whether the blur renderer
	///     permits transparency in the blur output. Set to `true` to create
	///     an opaque blur, or set to `false` to permit transparency.
	@inlinable public func blur(radius: Length, opaque: Bool = false) -> Self.Modified<_BlurEffect>
}

extension View {
	/// Positions this view within an invisible frame with the specified size.
	///  Use this method to specify a fixed size for a view's width,
	/// height, or both. If you only specify one of the dimensions, the
	/// resulting view assumes this view's sizing behavior in the other
	/// dimension.
	///  For example, the first ellipse in the following code is rendered in a
	/// fixed 200 by 100 frame. The second ellipse has only its height fixed,
	/// at 100; its width still expands to fill its parent's dimensions.
	/// 	VStack {
	///         Ellipse()
	///         .fill(Color.purple)
	///         .frame(width: 100, height: 100),
	///         Ellipse()
	///         .fill(Color.blue)
	///         .frame(height: 100)
	///     }
	///  **Image: frame**
	///  If this view is smaller than the resulting frame in either dimension,
	/// `alignment` specifies this view's alignment within the frame.
	/// 	Text("Hello world!")
	///     .frame(width: 200, height: 200, alignment: topLeading)
	///     .border(Color.gray)
	///  **Image: frame_alignment**
	///  - Parameters:
	///   - width: A fixed width for the resulting view. If `width` is `nil`,
	///     the resulting view assumes this view's sizing behavior.
	///   - height: A fixed width for the resulting view. If `width` is `nil`,
	///     the resulting view assumes this view's sizing behavior.
	///   - alignment: The alignment of this view inside the resulting view.
	///     `alignment` applies if this view is smaller than the size given
	///     by the resulting frame.
	/// - Returns: A view with fixed dimensions of `width` and `height`, for
	///   the parameters that are non-`nil`.
	@inlinable public func frame(width: Length? = nil, height: Length? = nil, alignment: Alignment = .center) -> Self.Modified<_FrameLayout>

	/// This function should never be used.
	///  It is merely a hack to catch the case where the user writes .frame(),
	/// which is nonsensical.
	@available(*, deprecated, message: "Please pass one or more parameters.")
	@inlinable public func frame() -> Self.Modified<_FrameLayout>
}

extension View {
	/// Positions this view within an invisible frame with the specified width
	/// and height characteristics.
	///  Always specify at least one size characteristic when calling this
	/// method. Pass `nil` or leave out a characteristic to indicate that
	/// the frame should adopt this view's sizing behavior, constrained by
	/// the other non-`nil` arguments.
	///  Any non-`nil` minimum, ideal, or maximum parameters specified for
	/// each dimension must be in ascending order.
	///  - Parameters:
	///   - minWidth: The minimum width for the resulting frame.
	///   - idealWidth: The ideal width for the resulting frame.
	///   - maxWidth: The maximum width for the resulting frame.
	///   - minHeight: The minimum height for the resulting frame.
	///   - idealHeight: The ideal height for the resulting frame.
	///   - maxHeight: The maximum height for the resulting frame.
	///   - alignment: The alignment of this view inside the resulting frame.
	///     `alignment` applies if this view is smaller than the size given
	///     by the resulting frame.
	/// - Returns: A view with flexible dimensions given by the call's non-`nil`
	///   parameters.
	@inlinable public func frame(minWidth: Length? = nil, idealWidth: Length? = nil, maxWidth: Length? = nil, minHeight: Length? = nil, idealHeight: Length? = nil, maxHeight: Length? = nil, alignment: Alignment = .center) -> Self.Modified<_FlexFrameLayout>
}

extension View {
	/// Brightens this view by the specified amount.
	///  The following shows two versions of the same image side by side; at left
	/// is the original, and at right is a duplicate with its brightness set to
	/// 0.6:
	///  **Image: brightness_value_0.6**
	///  - Parameter amount: A value between 0 (no effect) and 1 (full white
	///     brightening) that represents the intensity of the brightness effect.
	/// - Returns: A view that brightens this view by the specified amount.
	@inlinable public func brightness(_ amount: Double) -> Self.Modified<_BrightnessEffect>
}

extension View {
	/// Returns a view modified so that its value for the given `guide` is the
	/// result of passing the `ViewDimensions` of the underlying view to
	/// `computeValue`.
	public func alignmentGuide(_ g: HorizontalAlignment, computeValue: @escaping (ViewDimensions) -> Length) -> Self.Modified<_AlignmentWritingModifier>

	/// Returns a view modified so that its value for the given `guide` is the
	/// result of passing the `ViewDimensions` of the underlying view to
	/// `computeValue`.
	public func alignmentGuide(_ g: VerticalAlignment, computeValue: @escaping (ViewDimensions) -> Length) -> Self.Modified<_AlignmentWritingModifier>
}

extension View {
	/// Inverts the colors in this view.
	///  The `colorInvert()` modifier inverts all of the colors in a view so that
	/// each color displays as its complementary color. For example, blue
	/// converts to yellow, and white converts to black.
	///  The following shows two version of the same image side by side; at left
	/// is the original, and at right is a duplicate with its colors inverted:
	///  **Image: colorInvert**
	///  - Returns: A view that inverts its colors.
	@inlinable public func colorInvert() -> Self.Modified<_ColorInvertEffect>
}

extension View {
	/// Adds a color multiplication effect to this view.
	///  The following shows two versions of the same image side by side; at left
	/// is the original, and at right is a duplicate with the
	/// `colorMultiply(_:)` modifier applied with `Color.purple`.
	///  - Parameter color: The color to bias this view toward.
	/// - Returns: A view with a color multiplication effect.
	@inlinable public func colorMultiply(_ color: Color) -> Self.Modified<_ColorMultiplyEffect>
}

extension View {
	/// Sets the contrast and separation between similar colors in this view.
	///  Apply contrast to a view when you want to increase or decrease the
	/// separation between similar colors in the view. The following image shows
	/// a photo next to that same photo with the contrast set to 3:
	///  **Image: contrast_value_3**
	///  - Parameter amount: The intensity of color constrast to apply. Negative
	///     values invert colors in addition to applying contrast.
	/// - Returns: A view that applies color contrast to this view.
	@inlinable public func contrast(_ amount: Double) -> Self.Modified<_ContrastEffect>
}

extension View {
	/// Adds a grayscale effect to this view.
	///  A grayscale effect reduces the intensity of colors in this view. The
	/// following shows two versions of the same image side by side; at left is
	/// the original, and at right is a duplicate with the `grayscale(_:)`
	/// modifier's `amount` parameter set to 0.75:
	///  **Image: grayscale_value_0.75**
	///  - Parameter amount: The intensity of grayscale to apply. Values
	///   closer to 0.0 are more colorful, and values closer to 1.0 are less
	///   colorful.
	/// - Returns: A view that adds a grayscale effect to this view.
	@inlinable public func grayscale(_ amount: Double) -> Self.Modified<_GrayscaleEffect>
}

extension View {
	/// Applies a hue rotation effect to this view.
	///  A hue rotation effect shifts all of the colors in a view according
	/// to the angle you specify. The following shows two versions of the same
	/// image side by side; at left is the original, and at right is a duplicate
	/// with its hues rotated by 45 degrees:
	///  **Image: colorRotation_value_45deg**
	///  - Parameter angle: The hue rotation angle to apply to the colors in this
	///   view.
	/// - Returns: A view that applies a hue rotation effect to this view.
	@inlinable public func hueRotation(_ angle: Angle) -> Self.Modified<_HueRotationEffect>
}

extension View {
	/// Adds a luminance to alpha effect to this view.
	///  The `luminanceToAlpha()` modifier creates a semitransparent mask out of
	/// the view you apply it to. The dark regions in a view become transparent,
	/// and the bright regions become opaque black. Medium brightness regions
	/// become a partially opay gray color.
	///  The following shows two versions of the same image side by side; at left
	/// is the original, and at right is a duplicate with the
	/// `luminanceToAlpha()` modifier applied:
	///  **Image: luminanceToAlpha**
	///  Returns: A view that applies a luminance to alpha effect to this view.
	@inlinable public func luminanceToAlpha() -> Self.Modified<_LuminanceToAlphaEffect>
}

extension View {
	/// Adjusts the color saturation of this view.
	///  Changing color saturation increases or decreases the intensity of colors
	/// in a view. The following shows two versions of the same image side by
	/// side; at left is the original, and at right is a duplicate with its
	/// saturation set to 3.5:
	///  **Image: saturation_value_3.5**
	///  - Parameter amount: The amount of saturation to apply to this view.
	/// - Returns: A view that adjusts the saturation of this view.
	@inlinable public func saturation(_ amount: Double) -> Self.Modified<_SaturationEffect>
}

extension View {
	/// Sets the transparency of this view.
	///  Apply opacity to reveal views that are behind another view or to
	/// de-emphasize a view.
	/// The following shows two versions of the same image side by side; at left
	/// is the original, and at right is a duplicate with its opacity set to
	/// 0.5:
	///  **Image: opacity_value_0.5**
	///  When applying the `opacity(_:)` modifier to a view that already has
	/// an opacity, the modifier supplements---rather than replaces---the view's
	/// opacity.
	///  - Parameter opacity: A value between 0 (fully transparent) and 1
	///     (fully opaque).
	/// - Returns: A view that sets the transparency of this view.
	@inlinable public func opacity(_ opacity: Double) -> Self.Modified<_OpacityEffect>
}

extension View {
	/// Applies the given animation to this view, whenever the specified value
	/// changes.
	///  - Parameters:
	///   - animation: The animation to apply. If `animation` is `nil`, the view
	///     doesn't animate.
	///   - value: A value to monitor for changes.
	/// - Returns: A view that applies `animation` to this view whenever `value`
	///   changes.
	@inlinable public func animation<V>(_ animation: Animation?, value: V) -> Self.Modified<_AnimationModifier<V>> where V : Equatable
}

extension View {
	/// Sets the blend mode for compositing this view with overlapping views.
	///  - Parameter blendMode: The blend mode for compositing this view.
	/// - Returns: A view that applies `blendMode` to this view.
	@inlinable public func blendMode(_ blendMode: BlendMode) -> Self.Modified<_BlendModeEffect>
}

extension View {
	/// Returns a view wrapping `self` that transforms the value of the
	/// environment key described by `keyPath` by applying a transform
	/// function.
	@inlinable public func transformEnvironment<V>(_ keyPath: WritableKeyPath<EnvironmentValues, V>, transform: @escaping (inout V) -> Void) -> Self.Modified<_EnvironmentKeyTransformModifier<V>>
}

extension View {
	/// Sets the style for `Toggle` within the environment of `self`
	public func toggleStyle<S>(_ style: S.Member) -> Self.Modified<_ToggleStyleModifier<S>> where S : ToggleStyle
}

extension View {
	/// Composites this view's contents into an offscreen image before final
	/// display.
	///  Views backed by native platform views don't render into the image.
	/// Instead, they log a warning and display a placeholder image to highlight
	/// the error.
	///  - Parameters:
	///   - opaque: A Boolean value that indicates whether the image is opaque.
	///     If `true`, the alpha channel of the image must be one.
	///   - colorMode: The working color space and storage format of the image.
	/// - Returns: A view that composites this view's contents into an offscreen
	///   image before display.
	public func drawingGroup(opaque: Bool = false, colorMode: ColorRenderingMode = .nonLinear) -> Self.Modified<_DrawingGroupEffect>
}

extension View {
	/// Wraps this view in a compositing group.
	///  A compositing group makes compositing effects in this view's ancestor
	/// views, like opacity and the blend mode, take effect before this view
	/// renders.
	///  - Returns: A view that wraps this view in a compositing group.
	@inlinable public func compositingGroup() -> Self.Modified<_CompositingGroupEffect>
}

extension View {
	/// Adds a shadow to this view.
	///  - Parameters:
	///   - color: The shadow's color.
	///   - radius: The shadow's size.
	///   - x: A horizontal offset you use to position the shadow relative to
	///     this view.
	///   - y: A vertical offset you use to position the shadow relative to
	///     this view.
	/// - Returns: A view that adds a shadow to this view.
	@inlinable public func shadow(color: Color = Color(.sRGBLinear, white: 0, opacity: 0.33), radius: Length, x: Length = 0, y: Length = 0) -> Self.Modified<_ShadowEffect>
}

extension View {
	/// Adds an action to perform when the given publisher emits an event.
	///  - Parameters:
	///   - publisher: The publisher to subscribe to.
	///   - action: The action to perform when an event is emitted by
	///     `publisher`. The event emitted by publisher is passed as a
	///     parameter to `action`.
	/// - Returns: A view that triggers `action` when `publisher` emits an
	///   event.
	public func onReceive<P>(_ publisher: P, perform action: @escaping (P.Output) -> Void) -> SubscriptionView<P, Self> where P : Publisher, P.Failure == Never

	/// Adds an action to perform when the given publisher emits an event.
	///  - Parameters:
	///   - publisher: The publisher to subscribe to.
	///   - action: The action to perform when an event is emitted by
	///     `publisher`.
	/// - Returns: A view that triggers `action` when `publisher` emits an
	///   event.
	public func onReceive<P>(_ publisher: P, perform action: @escaping () -> Void) -> SubscriptionView<P, Self> where P : Publisher, P.Failure == Never
}

extension View {
	/// Sets the tag of the view, used for selecting from a list of `View`
	/// options.
	///  - SeeAlso: `List`, `Picker`
	public func tag<V>(_ tag: V) -> _AutoResultView<Self> where V : Hashable
}

extension View {
	/// Sets this view's color scheme.
	///  - Parameter colorScheme: The color scheme for this view.
	/// - Returns: A view that sets this view's color scheme.
	public func colorScheme(_ colorScheme: ColorScheme) -> Self.Modified<_EnvironmentKeyWritingModifier<ColorScheme>>

	/// Sets the default font for text in this view.
	///  - Parameter font: The default font to use in this view.
	/// - Returns: A view with the default font set to the value you supply.
	public func font(_ font: Font?) -> Self.Modified<_EnvironmentKeyWritingModifier<Font?>>
}

extension View {
	/// Add an accessibility action to an element.
	public func accessibilityAction(_ actionType: AccessibilityActionType = .default, _ handler: @escaping () -> Void) -> Self.Modified<AccessibilityModifier>

	/// Add a custom action to an element and all sub-elements.
	public func accessibilityAction(named name: Text, _ handler: @escaping () -> Void) -> Self.Modified<AccessibilityModifier>
}

extension View {
	/// Presents a popover to the user.
	///  - Parameters:
	///     - popover: The popover to present. If `nil`, no popover is presented.
	/// 	public func presentation(_ popover: Popover?) -> _AutoResultView<Self>
}

extension View {
	/// Provides a closure that vends the drag representation to be used for a
	/// particular `DynamicContent`.
	public func itemProvider(_ action: (() -> NSItemProvider?)?) -> Self.Modified<_TraitWritingModifier<(() -> NSItemProvider?)?>>
}

extension View {
	/// Adds a contextual menu to this view.
	///  Use contextual menus to add actions that change depending on the user's
	/// current focus and task.
	///  The following example creates text with a contextual menu:
	/// 	Text("Control Click Me")
	///     .contextMenu {
	///         Button(Text("Add")) {}
	///         Button(Text("Remove")) {}
	///     }
	///  - Returns: A view that adds a contextual menu to this view.
	public func contextMenu<MenuItems>(menuItems: () -> MenuItems) -> _VariadicView.Tree<_ContextMenuContainer.Container<Self>, AnyView> where MenuItems : View

	/// Attaches a `ContextMenu` and its children to `self`.
	///  This modifier allows for the contextual menu to be conditionally
	/// available by passing `nil` as the value for `contextMenu`.
	public func contextMenu<MenuItems>(_ contextMenu: ContextMenu<MenuItems>?) -> _VariadicView.Tree<_ContextMenuContainer.Container<Self>, AnyView?> where MenuItems : View
}

extension View {
	/// Sets the tab item to be used for this content.
	public func tabItemLabel<V>(_ item: V) -> Self.Modified<_TraitWritingModifier<AnyView?>> where V : View
}

extension View {
	/// Fixes this view at its ideal size in the specified dimensions.
	///  This example shows the effect of `fixedSize(horizontal:vertical:)` on
	/// a text view that is wider than its parent, preserving the ideal,
	/// untruncated width of the text view.
	/// 	Text("A single line of text, too long to fit in a box.")
	///     .fixedSize(horizontal: true, vertical: false)
	///     .frame(width: 200, height: 200)
	///     .border(Color.gray)
	///  **Image: fixedSize**
	///  Without the call to `fixedSize(_:)`, the text view has its width set
	/// by its parent, which truncates the line of text.
	/// 	Text("A single line of text, too long to fit in a box.")
	///     .frame(width: 200, height: 200)
	///     .border(Color.gray)
	///  **Image: fixedSize_nocall**
	///  - Parameters:
	///   - horizontal: A Boolean value indicating whether to fix the width of
	///     the view.
	///   - vertical: A Boolean value indicating whether to fix the height of
	///     the view.
	/// - Returns: A view that fixes this view at its ideal size in the
	///   dimensions specified by `horizontal` and `vertical`.
	public func fixedSize(horizontal: Bool, vertical: Bool) -> Self.Modified<_FixedSizeLayout>

	/// Fixes this view at its ideal size.
	///  This example shows the effect of `fixedSize()` on a text view that
	/// is wider than its parent, preserving the ideal, untruncated width
	/// of the text view.
	/// 	Text("A single line of text, too long to fit in a box.")
	///     .fixedSize()
	///     .frame(width: 200, height: 200)
	///     .border(Color.gray)
	///  **Image: fixedSize**
	///  Without the call to `fixedSize(_:)`, the text view has its width set
	/// by its parent, which truncates the line of text.
	/// 	Text("A single line of text, too long to fit in a box.")
	///     .frame(width: 200, height: 200)
	///     .border(Color.gray)
	///  **Image: fixedSize_nocall**
	///  - Returns: A view that fixes this view at its ideal size in the
	///   dimensions given in `fixedDimensions`.
	public func fixedSize() -> Self.Modified<_FixedSizeLayout>
}

extension View {
	@inlinable public func layout<T>(_ layout: T) -> Self.Modified<T> where T : ViewModifier
}

extension View {
	/// Sets the style for `DatePicker` within the environment of `self`
	public func datePickerStyle<S>(_ style: S.Member) -> Self.Modified<_DatePickerStyleModifier<S>> where S : DatePickerStyle
}

extension View {
	@inlinable public func anchorPreference<A, K>(key _: K.Type = K.self, value: Anchor<A>.Source, transform: @escaping (Anchor<A>) -> K.Value) -> Self.Modified<_AnchorWritingModifier<A, K>> where A : Equatable, K : PreferenceKey
}

extension View {
	/// Returns a version of `self` that will invoke `action` after
	/// recognizing a longPress gesture.
	public func longPressAction(minimumDuration: Double = 0.5, maximumDistance: Length = 10, _ action: @escaping () -> Void, pressing: ((Bool) -> Void)? = nil) -> _AutoResultView<Self>
}

extension View {
	/// Sets the style for `Slider` within the environment of `self`.
	public func sliderStyle(_ style: AnySliderStyle) -> Self.Modified<_EnvironmentKeyWritingModifier<AnySliderStyle>>
}

extension View {
	/// Convenience function for attaching an AccessibilityScrollAction to a
	/// view.
	public func accessibilityScrollAction(_ handler: @escaping (Edge) -> Void) -> Self.Modified<AccessibilityModifier>
}

extension View {
	/// Sets the style for `PullDownButton` within the environment of `self`.
	public func pullDownButtonStyle(_ style: AnyPullDownButtonStyle) -> Self.Modified<_EnvironmentKeyWritingModifier<AnyPullDownButtonStyle>>
}

extension View {
	public func accessibilityElement(children: AccessibilityParentBehavior = .contain) -> Self.Modified<_AccessibilityContainerModifier>
}

extension View {
	/// Adds an action to perform when this view appears.
	///  - Parameter action: The action to perform. If `action` is `nil`, the
	///   call has no effect.
	/// - Returns: A view that triggers `action` when this view appears.
	public func onAppear(perform action: (() -> Void)? = nil) -> Self.Modified<_AppearanceActionModifier>

	/// Adds an action to perform when this view disappears.
	///  - Parameter action: The action to perform. If `action` is `nil`, the
	///   call has no effect.
	/// - Returns: A view that triggers `action` when this view disappears.
	public func onDisappear(perform action: (() -> Void)? = nil) -> Self.Modified<_AppearanceActionModifier>
}

extension View {
	/// Sets whether this view flips its contents horizontally when the layout
	/// direction is right-to-left.
	///  - Parameter enabled: A Boolean value that indicates whether this view
	///   flips its content horizontally when the layout direction is
	///   right-to-left.
	/// - Returns: A view that conditionally flips its contents horizontally
	/// when the layout direction is right-to-left.
	@inlinable public func flipsForRightToLeftLayoutDirection(_ enabled: Bool) -> Self.Modified<_FlipForRTLEffect>
}

extension View {
	@inlinable public func transformAnchorPreference<A, K>(key _: K.Type = K.self, value: Anchor<A>.Source, transform: @escaping (inout K.Value, Anchor<A>) -> Void) -> Self.Modified<_AnchorTransformModifier<A, K>> where A : Equatable, K : PreferenceKey
}

extension View {
	/// Convenience function for attaching an AccessibilityAdjustableAction to a
	/// view.
	public func accessibilityAdjustableAction(_ handler: @escaping (AccessibilityAdjustmentDirection) -> Void) -> Self.Modified<AccessibilityModifier>
}

extension View {
	/// The behavior of the view when being customized by the user.
	/// Views may be:
	/// - required and not allowed to be removed by the user
	/// - shown by default prior to user customization, but removable
	/// - not visible by default, but can be added through the palette
	public func touchBarItemPresence(_ presence: TouchBarItemPresence) -> Self.Modified<_TraitWritingModifier<TouchBarItemPresence?>>
}

extension View {
	/// Principal views have special significance to this TouchBar.
	/// Currently, that item will be placed in the center of the row.
	/// - Note: multiple visible bars may each specify a principal view,
	/// but only one of them can have the request honored.
	public func touchBarItemPrincipal(_ principal: Bool = true) -> Self.Modified<_TraitWritingModifier<Bool>>
}

extension View {
	/// The user-visible `String` identifying the view's functionality.
	/// Visible during user customization.
	public func touchBarCustomizationLabel(_ label: Text) -> Self.Modified<_TraitWritingModifier<Text>>
}

extension View {
	@inlinable public func rotation3DEffect(_ angle: Angle, axis: (x: CGFloat, y: CGFloat, z: CGFloat), anchor: UnitPoint = .center, anchorZ: Length = 0, perspective: Length = 1) -> Self.Modified<_Rotation3DEffect>
}

extension View {
	public func accessibility(visibility: AccessibilityVisibility) -> Self.Modified<AccessibilityModifier>
	public func accessibility(label: Text) -> Self.Modified<AccessibilityModifier>
	public func accessibility(value: Text) -> Self.Modified<AccessibilityModifier>
	public func accessibility(hint: Text) -> Self.Modified<AccessibilityModifier>
	public func accessibility(addTraits traits: AccessibilityTraits) -> Self.Modified<AccessibilityModifier>
	public func accessibility(removeTraits traits: AccessibilityTraits) -> Self.Modified<AccessibilityModifier>
	public func accessibility(identifier: String) -> Self.Modified<AccessibilityModifier>
	public func accessibility(activationPoint: CGPoint) -> Self.Modified<AccessibilityModifier>
	public func accessibility(activationPoint: UnitPoint) -> Self.Modified<AccessibilityModifier>
}

extension View {
	/// Sets the view to be placed behind `self` when placed in a `List`
	public func listRowBackground<V>(_ view: V?) -> Self.Modified<_TraitWritingModifier<AnyView?>> where V : View
}

extension View {
	/// Associates a transition with `self`.
	public func transition(_ t: AnyTransition) -> Self.Modified<_TraitWritingModifier<AnyTransition>>
}

extension View {
	/// Sets the Z index for an item.
	public func zIndex(_ value: Double) -> Self.Modified<_TraitWritingModifier<Double>>
}

extension View {
	/// Extends the view out of the safe area on the specified edges.
	///  - Parameter edges: The set of the edges on which to ignore the safe
	///   area.
	/// - Returns: A view that extends this view out of the safe area on
	///   the edges specified by `edges`.
	@inlinable public func edgesIgnoringSafeArea(_ edges: Edge.Set) -> Self.Modified<_SafeAreaIgnoringLayout>
}

extension View {
	/// Returns a view producing `value` as the value of preference
	/// `Key` seen by its ancestors.
	@inlinable public func preference<K>(key _: K.Type = K.self, value: K.Value) -> Self.Modified<_PreferenceWritingModifier<K>> where K : PreferenceKey
}

extension View {
	/// Sets the style for `Picker` within the environment of `self`.
	public func pickerStyle<S>(_ style: S.Member) -> Self.Modified<_PickerStyleWriter<S>> where S : PickerStyle
}

extension View {
	/// Sets the style for `List` within the environment of `self`.
	public func listStyle<S>(_ style: S.Member) -> _AutoResultView<(Self, S)> where S : ListStyle
}

extension View {
	/// Sets the style for `TextField` within the environment of `self`.
	public func textFieldStyle<S>(_ style: S.Member) -> Self.Modified<TextFieldStyleModifier<S>> where S : TextFieldStyle
}

extension View {
	public func controlSize(_ controlSize: ControlSize) -> Self.Modified<_EnvironmentKeyWritingModifier<ControlSize>>
}

extension View {
	/// Sets a clipping shape for this view.
	///  By applying a clipping shape to a view, you preserve the parts of the
	/// view covered by the shape, while eliminating other parts of the view.
	/// The clipping shape itself isn't visible.
	///  For example, this code applies clipping shape to a square image:
	/// 	Image(name: "artichokes")
	///         .clipShape(Circle())
	///  The resulting view shows only the portion of the image that lies within
	/// the bounds of the circle.
	///  **Image: clipShape**
	///  - Parameters:
	///   - shape: The clipping shape to use for this view. The `shape` fills
	///     the view's frame, while maintaining its aspect ratio.
	///   - style: The fill style to use when rasterizing `shape`.
	/// - Returns: A view that clips this view to `shape`, using `style` to
	///   define the shape's rasterization.
	@inlinable public func clipShape<S>(_ shape: S, style: FillStyle = FillStyle()) -> Self.Modified<_ClipEffect<S>> where S : Shape

	/// Clips this view to its bounding rectangular frame.
	///  By default, a view's bounding frame is used only for layout, so any
	/// content that extends beyond the edges of the frame is still visible.
	/// Use the `clipped()` modifier to hide any content that extends beyond
	/// these edges.
	///  - Parameter antialiased: A Boolean value that indicates whether
	///   smoothing is applied to the edges of the clipping rectangle.
	/// - Returns: A view that clips this view to its bounding frame.
	@inlinable public func clipped(antialiased: Bool = false) -> Self.Modified<_ClipEffect<Rectangle>>

	/// Clips this view to its bounding frame, with the specified corner radius.
	///  By default, a view's bounding frame only affects its layout, so any
	/// content that extends beyond the edges of the frame remains visible.
	/// Use the `cornerRadius()` modifier to hide any content that extends
	/// beyond these edges while applying a corner radius.
	///  The following code applies a corner radius of 20 to a square image:
	/// 	Image(name: "walnuts")
	///         .cornerRadius(20)
	///  **Image: cornerRadius**
	///  - Parameter antialiased: A Boolean value that indicates whether
	///   smoothing is applied to the edges of the clipping rectangle.
	/// - Returns: A view that clips this view to its bounding frame.
	@inlinable public func cornerRadius(_ radius: Length, antialiased: Bool = true) -> Self.Modified<_ClipEffect<RoundedRectangle>>
}

extension View {
	/// Sets the inset to be applied to `self` in a `List`.
	public func listRowInsets(_ insets: EdgeInsets?) -> Self.Modified<_TraitWritingModifier<EdgeInsets?>>
}

extension View {
	/// Sets the alignment of multiline text in this view.
	///  - Parameter alignment: A value you use to align lines of text to the
	///   left, right, or center.
	/// - Returns: A view that aligns the lines of multiline `Text` instances
	///   it contains.
	public func multilineTextAlignment(_ alignment: HAlignment) -> Self.Modified<_EnvironmentKeyWritingModifier<HAlignment>>

	/// Sets the truncation mode for lines of text that are too long to fit in
	/// the available space.
	///  Use the `truncationMode(_:)` modifier to determine whether text in a
	/// long line is truncated at the beginning, middle, or end. Truncation
	/// adds an ellipsis (…) to the line when removing text to indicate to
	/// readers that text is missing.
	///  - Parameter mode: The truncation mode.
	/// - Returns: A view that truncates text at different points in a line
	///   depending on the mode you select.
	public func truncationMode(_ mode: Text.TruncationMode) -> Self.Modified<_EnvironmentKeyWritingModifier<Text.TruncationMode>>

	/// Sets the amount of space between lines of text in this view.
	///  - Parameter lineSpacing: The amount of space between the bottom of one
	///   line and the top of the next line.
	public func lineSpacing(_ lineSpacing: Length) -> Self.Modified<_EnvironmentKeyWritingModifier<Length>>

	/// Sets whether text in this view can compress the space between characters
	/// when necessary to fit text in a line.
	///  - Parameter flag: A Boolean value that indicates whether the space
	///   between characters compresses when necessary.
	/// - Returns: A view that can compress the space between characters when
	///   necessary to fit text in a line.
	public func allowsTightening(_ flag: Bool) -> Self.Modified<_EnvironmentKeyWritingModifier<Bool>>

	/// Sets the maximum number of lines that text can occupy in this view.
	///  The line limit applies to all `Text` instances within this view. For
	/// example, an `HStack` with multiple pieces of text longer than three
	/// lines caps each piece of text to three lines rather than capping the
	/// total number of lines across the `HStack`.
	///  - Parameter number: The line limit. If `nil`, no line limit applies.
	/// - Returns: A view that limits the number of lines that `Text` instances
	///   display.
	public func lineLimit(_ number: Int?) -> Self.Modified<_EnvironmentKeyWritingModifier<Int?>>

	/// Sets the minimum amount that text in this view scales down to fit in the
	/// available space.
	///  Use the `minimumScaleFactor(_:)` modifier if the text you place in a
	/// view doesn't fit and it's okay if the text shrinks to accommodate.
	/// For example, a label with a `minimumScaleFactor` of `0.5` draws its
	/// text in a font size as small as half of the actual font if needed.
	///  - Parameter factor: A fraction between 0 and 1 (inclusive) you use to
	///   specify the minimum amount of text scaling that this view permits.
	/// - Returns: A view that limits the amount of text downscaling.
	public func minimumScaleFactor(_ factor: Length) -> Self.Modified<_EnvironmentKeyWritingModifier<Length>>
}

extension View {
	/// Returns a view that applies `callback(&value)` to the value of
	/// preference `Key` that's seen by its ancestors.
	@inlinable public func transformPreference<K>(_ key: K.Type = K.self, _ callback: @escaping (inout K.Value) -> Void) -> Self.Modified<_PreferenceTransformModifier<K>> where K : PreferenceKey
}

extension View {
	/// Presents an sheet to the user attached to the view's window.
	///  - Parameters:
	///     - sheet: The sheet to present. If `nil`, no sheet is presented.
	public func presentation(_ sheet: Sheet?) -> _AutoResultView<Self>
}

extension View {
	/// Sets the priority by which a parent layout should apportion
	/// space to this child.
	///  The default priority is `0`.  In a group of sibling views,
	/// raising a view's layout priority encourages that view to shrink
	/// later when the group is shrunk and stretch sooner when the group
	/// is stretched.
	///  A parent layout should offer the child(ren) with the highest
	/// layout priority all the space offered to the parent minus the
	/// minimum space required for all its lower-priority children, and
	/// so on for each lower priority value.
	public func layoutPriority(_ value: Double) -> Self.Modified<_TraitWritingModifier<Double>>
}

extension View {
	/// Returns a view that reads the value of preference `Key` from
	/// `self`, uses that to produce another view which is displayed as
	/// an overlay on `self`.
	@inlinable public func overlayPreferenceValue<Key, T>(_ key: Key.Type = Key.self, _ transform: @escaping (Key.Value) -> T) -> _DelayedPreferenceView<Key, Self.Modified<_OverlayModifier<_PreferenceReadingView<Key, T>>>> where Key : PreferenceKey, T : View

	/// Returns a view that reads the value of preference `Key` from
	/// `self`, uses that to produce another view which is displayed as
	/// as the background to `self`.
	@inlinable public func backgroundPreferenceValue<Key, T>(_ key: Key.Type = Key.self, _ transform: @escaping (Key.Value) -> T) -> _DelayedPreferenceView<Key, Self.Modified<_BackgroundModifier<_PreferenceReadingView<Key, T>>>> where Key : PreferenceKey, T : View
}

extension View {
	@inlinable public func coordinateSpace<T>(name: T) -> Self.Modified<_CoordinateSpaceModifier<T>> where T : Hashable
}

extension View {
	/// Supplies a `BindableObject` to a view subhierachy.
	///  The object can be read by any child by using `EnvironmentObject`.
	///  - Parameter bindable: the object to store and make available to
	///     the view's subhiearchy.
	public func environmentObject<B>(_ bindable: B) -> Self.Modified<_EnvironmentKeyWritingModifier<B?>> where B : BindableObject
}

extension View {
	/// Sets the style for `.radioGroup` style `Picker`s within the environment
	/// of `self` to be radio buttons horizontally arranged inside of `layout`.
	public func horizontalRadioGroupLayout() -> _AutoResultView<Self>
}

extension View {
	public func linkButtonStyle() -> _AutoResultView<Self>
	public func borderlessButtonStyle() -> _AutoResultView<Self>
}

/// The `ViewBuilder` type is a custom parameter attribute that constructs views from multi-statement
/// closures.
///
/// The typical use of `ViewBuilder` is as a parameter attribute for child view-producing closure
/// parameters, allowing those closures to provide multiple child views. For example, the following
/// `contextMenu` function accepts a closure that produces one or more views via the `ViewBuidler`.
///
/// ```
/// func contextMenu<MenuItems : View>(
///         @ViewBuilder menuItems: () -> MenuItems
///     ) -> some View
/// ```
///
/// Clients of this function can use multiple-statement closures to provide several child views, e.g.,
///
/// ```
/// myView.contextMenu {
///     Text("Cut")
///     Text("Copy")
///     Text("Paste")
///     if isSymbol {
///         Text("Jump to Definition")
///     }
/// }
/// ```
@_functionBuilder public struct ViewBuilder {
	/// Builds an empty view from an block containing no statements, `{ }`.
	public static func buildBlock() -> EmptyView

	/// Passes a single view written as a child view (e..g, `{ Text("Hello") }`) through
	/// unmodified.
	public static func buildBlock<Content>(_ content: Content) -> Content where Content : View
}

extension ViewBuilder {
	/// Provides support for "if" statements in multi-statement closures, producing an `Optional` view
	/// that is visible only when the `if` condition evaluates `true`.
	public static func buildIf<Content>(_ content: Content?) -> Content? where Content : View

	/// Provides support for "if" statements in multi-statement closures, producing
	/// ConditionalContent for the "then" branch.
	public static func buildEither<TrueContent, FalseContent>(first: TrueContent) -> ConditionalContent<TrueContent, FalseContent> where TrueContent : View, FalseContent : View

	/// Provides support for "if-else" statements in multi-statement closures, producing
	/// ConditionalContent for the "else" branch.
	public static func buildEither<TrueContent, FalseContent>(second: FalseContent) -> ConditionalContent<TrueContent, FalseContent> where TrueContent : View, FalseContent : View
}

extension ViewBuilder {
	public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> TupleView<(C0, C1)> where C0 : View, C1 : View
}

extension ViewBuilder {
	public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> TupleView<(C0, C1, C2)> where C0 : View, C1 : View, C2 : View
}

extension ViewBuilder {
	public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> TupleView<(C0, C1, C2, C3)> where C0 : View, C1 : View, C2 : View, C3 : View
}

extension ViewBuilder {
	public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> TupleView<(C0, C1, C2, C3, C4)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View
}

extension ViewBuilder {
	public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> TupleView<(C0, C1, C2, C3, C4, C5)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View
}

extension ViewBuilder {
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> TupleView<(C0, C1, C2, C3, C4, C5, C6)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View
}

extension ViewBuilder {
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View
}

extension ViewBuilder {
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View
}

extension ViewBuilder {
	public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View, C9 : View
}

/// A view's size and its alignment guides in its own coordinate space.
public struct ViewDimensions {
	/// The view's width
	public var width: Length { get }

	/// The view's height
	public var height: Length { get }

	/// Accesses the value of the given guide.
	public subscript(guide: HorizontalAlignment) -> Length { get }

	/// Accesses the value of the given guide.
	public subscript(guide: VerticalAlignment) -> Length { get }

	/// Returns the explicit value of the given alignment guide in this view, or
	/// `nil` if no such value exists.
	public subscript(explicit guide: HorizontalAlignment) -> Length? { get }

	/// Returns the explicit value of the given alignment guide in this view, or
	/// `nil` if no such value exists.
	public subscript(explicit guide: VerticalAlignment) -> Length? { get }
}

extension ViewDimensions : Equatable {
}

/// A modifier that can be applied to a view or other view modifier,
/// producing a different version of the original value.
public protocol ViewModifier {
	/// The type of view representing the body of `Self`.
	associatedtype Body : View

	/// Returns the current body of `self`. `content` is a proxy for
	/// the view that will have the modifier represented by `Self`
	/// applied to it.
	func body(content: Self.Content) -> Self.Body

	/// The content view type passed to `body()`.
	typealias Content
}

extension ViewModifier {
	/// Returns a new version of the modifier that will apply the
	/// transaction mutation function `transform` to all transactions
	/// within the modifier.
	public func transaction(_ transform: @escaping (inout Transaction) -> Void) -> _PopTransactionModifier._Modified<Self>._Modified<_PushTransactionModifier>

	/// Returns a new version of the modifier that will apply
	/// `animation` to all animatable values within the modifier.
	public func animation(_ animation: Animation?) -> _PopTransactionModifier._Modified<Self>._Modified<_PushTransactionModifier>
}

extension ViewModifier where Self.Body == Never {
	public func body(content: Self.Content) -> Self.Body
}

/// A view that overlays its children, aligning them in both axes.
public struct ZStack<Content> where Content : View {
	@inlinable public init(alignment: Alignment = .center, content: () -> Content)

	public typealias Body = Never
}

/// Returns the result of executing `body` with `animation` installed
/// as the thread's current animation, by setting it as the animation
/// property of the thread's current transaction.
public func withAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result

/// Returns the result of executing `body()` with `transaction`
/// installed as the thread's current transaction.
public func withTransaction<Result>(_ transaction: Transaction, _ body: () throws -> Result) rethrows -> Result

extension Optional : Publisher where Wrapped : Publisher {
	/// The kind of values published by this publisher.
	public typealias Output = Wrapped.Output

	/// The kind of errors this publisher might publish.
	///  Use `Never` if this `Publisher` does not publish errors.
	public typealias Failure = Wrapped.Failure

	/// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
	///  - SeeAlso: `subscribe(_:)`
	/// - Parameters:
	///     - subscriber: The subscriber to attach to this `Publisher`.
	///                   once attached it can begin to receive values.
	public func receive<S>(subscriber: S) where S : Subscriber, Wrapped.Failure == S.Failure, Wrapped.Output == S.Input
}

extension Optional where Wrapped : View {
}

extension Optional : View where Wrapped : View {
	/// The type of view representing the body of this view.
	///  When you create a custom view, Swift infers this type from your implementation of the required `body` property.
	public typealias Body = Never
}

extension Float : VectorArithmetic {
}

extension Double : VectorArithmetic {
}

extension CGFloat : VectorArithmetic {
}

extension Int : Identifiable {
}

extension Collection {
	/// Returns a collection of identifier-value pairs computed on demand by
	/// calling `getID`.
	public func identified<ID>(by getID: KeyPath<Self.Element, ID>) -> IdentifierValuePairs<Self, ID> where ID : Hashable
}

extension CGPoint {
	public func applying(_ m: ProjectionTransform) -> CGPoint
}

extension Int {
	public var arg: Int64 { get }
	public var specifier: String { get }
	public typealias Arg = Int64
}

extension Int8 {
	public var arg: Int32 { get }
	public var specifier: String { get }
	public typealias Arg = Int32
}

extension Int16 {
	public var arg: Int32 { get }
	public var specifier: String { get }
	public typealias Arg = Int32
}

extension Int32 {
	public var arg: Int32 { get }
	public var specifier: String { get }
	public typealias Arg = Int32
}

extension Int64 {
	public var arg: Int64 { get }
	public var specifier: String { get }
	public typealias Arg = Int64
}

extension UInt {
	public var arg: UInt64 { get }
	public var specifier: String { get }
	public typealias Arg = UInt64
}

extension UInt8 {
	public var arg: UInt32 { get }
	public var specifier: String { get }
	public typealias Arg = UInt32
}

extension UInt16 {
	public var arg: UInt32 { get }
	public var specifier: String { get }
	public typealias Arg = UInt32
}

extension UInt32 {
	public var arg: UInt32 { get }
	public var specifier: String { get }
	public typealias Arg = UInt32
}

extension UInt64 {
	public var arg: UInt64 { get }
	public var specifier: String { get }
	public typealias Arg = UInt64
}

extension Float {
	public var arg: Float { get }
	public var specifier: String { get }
	public typealias Arg = Float
}

extension Float80 {
	public var arg: Float80 { get }
	public var specifier: String { get }
	public typealias Arg = Float80
}

extension Double {
	public var arg: Double { get }
	public var specifier: String { get }
	public typealias Arg = Double
}

extension CGFloat {
	public var arg: CGFloat { get }
	public var specifier: String { get }
	public typealias Arg = CGFloat
}

extension Never {
	/// The type of value produced by this gesture.
	public typealias Value = Never
}

extension NSView : CALayerDelegate {
}

extension Never {
	/// The type of view representing the body of this view.
	/// When you create a custom view, Swift infers this type from your
	/// implementation of the required `body` property.
	public typealias Body = Never
	public var body: Never { get }
}

/// Extends `T?` to conform to `Gesture` type if `T` also conforms to
/// `Gesture`. A nil value is mapped to an empty (i.e. failing)
/// gesture.
extension Optional : Gesture where Wrapped : Gesture {
	/// The type of value produced by this gesture.
	public typealias Value = Wrapped.Value
}

extension Never : View {
}

extension CGPoint : Animatable {
	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<Length, Length>

	/// The data to be animated.
	public var animatableData: CGPoint.AnimatableData
}

extension CGSize : Animatable {
	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<Length, Length>

	/// The data to be animated.
	public var animatableData: CGSize.AnimatableData
}

extension CGRect : Animatable {
	/// The type defining the data to be animated.
	public typealias AnimatableData = AnimatablePair<CGPoint.AnimatableData, CGSize.AnimatableData>

	/// The data to be animated.
	public var animatableData: CGRect.AnimatableData
}

extension Set : SelectionManager {
	public typealias SelectionValue = Element

	/// Selects `value`.
	public mutating func select(_ value: Element)

	/// Deselects `value`.
	public mutating func deselect(_ value: Element)

	/// Whether `value` is currently selected.
	public func isSelected(_ value: Element) -> Bool
}

extension Never : SelectionManager {
	public typealias SelectionValue = Never

	/// Selects `value`.
	public mutating func select(_ value: Never)

	/// Deselects `value`.
	public mutating func deselect(_ value: Never)

	/// Whether `value` is currently selected.
	public func isSelected(_ value: Never) -> Bool
}

extension Optional : SelectionManager where Wrapped : Hashable {
	public typealias SelectionValue = Wrapped

	/// Selects `value`.
	public mutating func select(_ value: Wrapped)

	/// Deselects `value`.
	public mutating func deselect(_ value: Wrapped)

	/// Whether `value` is currently selected.
	public func isSelected(_ value: Wrapped) -> Bool

	/// Whether multiple selection is allowed. The default value is `true`.
	public var allowsMultipleSelection: Bool { get }
}

extension Never : Gesture {
}

