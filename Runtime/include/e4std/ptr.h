/* * This is an open source non-commercial project. Dear PVS-Studio, please
 * check it.
 * PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com
 */

#pragma once
//
// A custom, badly written replacement for C++ smart pointers
//

#include "e4platf/mem.h"
#include "e4std/stuff.h"

#include <stddef.h>
#include <cstdint>
#include <bits/unique_ptr.h>

namespace e4std {

#if 0
template <class ValueType, class Allocator>
class TUniquePtr {
 private:
  ValueType* p_ = nullptr;

 public:
  TUniquePtr() {}

  explicit TUniquePtr(ValueType* p) : p_(p) {}
  TUniquePtr(const TUniquePtr& other) = delete;

  TUniquePtr(TUniquePtr&& other) : p_(std::move(other.p_)) {}

  ~TUniquePtr() { release(); }

  operator bool() const { return p_ != nullptr; }

  TUniquePtr& operator=(TUniquePtr& other) {
    take_over(other);
    return *this;
  }

  TUniquePtr& operator=(TUniquePtr&& other) {
    take_over(other);
    return *this;
  }

  void take_over(TUniquePtr& other) {
    release();
    p_ = other.p_;
    other.p_ = nullptr;
  }

  const ValueType* get() const { return p_; }

  ValueType* get() { return p_; }

  void release() {
    Allocator::free(p_);
    p_ = nullptr;
  }
};

template <class T>
using UniquePtr = TUniquePtr<T, platf::SingleAlloc>;

template <class T>
using UniqueArrayPtr = TUniquePtr<T, platf::ArrayAlloc>;
#endif //0

template <class T> using UniquePtr = std::unique_ptr<T>;
template <class T> using UniqueArrayPtr = std::unique_ptr<T[]>;

template <class T>
UniqueArrayPtr<T> make_array(::size_t sz) {
  auto data = platf::ArrayAlloc::alloc<T>(sz);
  return UniqueArrayPtr<T>(data);
}

}  // ns e4std
