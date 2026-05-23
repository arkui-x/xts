/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Union Literal Types
export type Direction = 'up' | 'down' | 'left' | 'right';

export type Size = 'small' | 'medium' | 'large';

export type Status = 'active' | 'inactive' | 'disabled';

export type Mode = 'light' | 'dark' | 'auto';

export type Align = 'start' | 'center' | 'end';

export type Shape = 'circle' | 'square' | 'rectangle';

export type Gender = 'male' | 'female' | 'other';

export type Language = 'zh' | 'en' | 'ja' | 'ko';

export type Network = 'wifi' | '4g' | '5g' | 'offline';

export type Priority = 'low' | 'medium' | 'high' | 'urgent';

// Enum Types
export enum Theme {
  Light = 'light',
  Dark = 'dark',
  Auto = 'auto'
}

export enum Position {
  Top = 'top',
  Bottom = 'bottom',
  Left = 'left',
  Right = 'right'
}

export enum Visibility {
  Visible = 'visible',
  Hidden = 'hidden',
  Collapsed = 'collapsed'
}

export enum Sort {
  Asc = 'asc',
  Desc = 'desc',
  None = 'none'
}

export enum Format {
  Json = 'json',
  Xml = 'xml',
  Csv = 'csv'
}

// Interface Definitions
export interface DirectionProps { dir?: Direction }

export interface SizeProps { size?: Size }

export interface StatusProps { status?: Status }

export interface ModeProps { mode?: Mode }

export interface AlignProps { align?: Align }

export interface ShapeProps { shape?: Shape }

export interface GenderProps { gender?: Gender }

export interface LanguageProps { lang?: Language }

export interface NetworkProps { network?: Network }

export interface PriorityProps { priority?: Priority }

export interface ThemeProps { theme?: Theme }

export interface PositionProps { position?: Position }

export interface VisibilityProps { visibility?: Visibility }

export interface SortProps { sort?: Sort }

export interface FormatProps { format?: Format }

// Combined Interfaces
export interface DirectionAndSizeProps extends DirectionProps, SizeProps {}

export interface StatusAndModeProps extends StatusProps, ModeProps {}

export interface AlignAndShapeProps extends AlignProps, ShapeProps {}

export interface GenderAndLanguageProps extends GenderProps, LanguageProps {}

export interface NetworkAndPriorityProps extends NetworkProps, PriorityProps {}

export interface ThemeAndPositionProps extends ThemeProps, PositionProps {}

export interface VisibilityAndSortProps extends VisibilityProps, SortProps {}

export interface FormatAndDirectionProps extends FormatProps, DirectionProps {}

// Type Selector Class
export class PropsHolder<T> {
  public props: T;

  constructor(props: T) {
    this.props = props;
  }

  get value(): T[keyof T] | undefined {
    const keys = Object.keys(this.props) as (keyof T)[];
    return keys.length > 0 ? this.props[keys[0]] : undefined;
  }
}

export class UnionTypeTest {
  // 1-10: Union Literal vs Single Enum Matching, Union Literal vs Interface Type Conversion (Core Basic Scenarios)
  test1() {
    const holder = new PropsHolder<ModeProps>({ mode: 'dark' });
    const enumVal = Theme.Dark;
    return holder.value === enumVal; // 'dark' vs 'dark' → true
  }

  // 11-20: Combined Interface vs Type Matching (Original 21-30 Scenarios)
  test4() {
    const holder = new PropsHolder<DirectionAndSizeProps>({ dir: 'up', size: 'small' });
    return holder.props.dir === 'up' && holder.props.size === 'small'; // Matching → true
  }

  test6() {
    const holder = new PropsHolder<StatusAndModeProps>({ status: 'inactive', mode: 'auto' });
    return holder.props.status === 'inactive' && holder.props.mode === 'auto'; // Matching → true
  }

  test8() {
    const holder = new PropsHolder<AlignAndShapeProps>({ align: 'center', shape: 'circle' });
    return holder.props.align === 'center' && holder.props.shape === 'circle'; // Matching → true
  }

  test10() {
    const holder = new PropsHolder<GenderAndLanguageProps>({ gender: 'other', lang: 'ja' });
    return holder.props.gender === 'other' && holder.props.lang === 'ja'; // Matching → true
  }

  test12() {
    const holder = new PropsHolder<NetworkAndPriorityProps>({ network: '4g', priority: 'medium' });
    return holder.props.network === '4g' && holder.props.priority === 'medium'; // Matching → true
  }

  // 21-30: Enum vs Union Literal Conversion (Original 31-40 Scenarios)
  test14() {
    const enumVal = Theme.Light;
    const literal: Mode = enumVal as Mode;
    return literal === 'light'; // Conversion matching → true
  }

  test16() {
    const enumVal = Theme.Dark;
    const literal: Mode = enumVal as Mode;
    return literal === 'dark'; // Conversion matching → true
  }

  test17() {
    const enumVal = Position.Left;
    const literal: Direction = enumVal as Direction;
    return literal === 'left'; // Conversion matching → true
  }

  // 31-40: Interface Nesting with Object Literals (Original 41-50 Scenarios)
  test18() {
    const obj: { props: DirectionProps } = { props: { dir: 'right' } };
    return obj.props.dir === 'right'; // Matching → true
  }
}
