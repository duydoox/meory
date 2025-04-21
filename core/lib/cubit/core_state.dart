// ignore_for_file: constant_identifier_names

part of '../core.dart';

abstract class CoreState extends Equatable {
  final bool isLoading;
  final String errorMessage;

  const CoreState({
    this.isLoading = false,
    this.errorMessage = '',
  });

  CoreState copyWith({
    bool? isLoading,
    String? errorMessage,
  });
}
